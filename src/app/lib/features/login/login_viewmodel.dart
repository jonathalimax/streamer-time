import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/features/webview/webview_screen.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:app/network/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class LoginViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _twitchService = locator<TwitchService>();
  final _appAuthentication = locator<AppAuthentication>();

  Future<bool> _handleUrl(String url) async {
    if (url.startsWith(redirectUri)) {
      _twitchService.client.initializeToken(TwitchToken.fromUrl(url));
      final token =
          await _twitchService.client.twitchHttpClient.validateToken();
      if (token != null) _makeLogin(token);
      return false;
    }
    return true;
  }

  Future<void> _makeLogin(TwitchToken token) async {
    locator.resetLazySingleton<FirestoreApi>();
    await _appAuthentication.persistToken(token);
    await _registerUser(token.userId);
    await _navigation.clearStackAndShow(Routes.homeScreen);
  }

  Future<void> startAuthentication() async {
    final List<TwitchApiScope> scopes = [
      TwitchApiScope.userReadFollow,
      TwitchApiScope.userReadEmail,
    ];

    final url = _twitchService.client.authorizeUri(scopes);
    final webViewScreen = WebViewScreen(
      url.toString(),
      _handleUrl,
    );
    await _navigation.navigateToView(
      webViewScreen,
      fullscreenDialog: true,
    );
  }

  Future _registerUser(String? userId) async {
    if (userId == null) return;

    final twitchUser = await _twitchService.client.getUsers(ids: [userId]);
    if (twitchUser.data == null) return;

    final user = User.fromTwitch(twitchUser: twitchUser.data!.first);
    return await _userService.createOrUpdate(user: user);
  }
}
