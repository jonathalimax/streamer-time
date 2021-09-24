import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/app_authentication.dart';
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
      if (token != null) {
        await _registerUser(token.userId);
        _appAuthentication.persisteToken(token);
        _navigation.clearStackAndShow(Routes.homeScreen);
      }
      return false;
    }
    return true;
  }

  void startAuthentication() {
    final List<TwitchApiScope> scopes = [
      TwitchApiScope.userReadFollow,
      TwitchApiScope.userReadEmail,
    ];

    final url = _twitchService.client.authorizeUri(scopes);
    _navigation.navigateTo(
      Routes.webViewScreen,
      arguments: WebViewScreenArguments(
        url: url.toString(),
        shouldNavigate: _handleUrl,
      ),
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
