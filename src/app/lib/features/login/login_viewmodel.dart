import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:app/services/twitch_service.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class LoginViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _appAuthentication = locator<AppAuthentication>();
  final _twitchService = locator<TwitchService>();

  final _webviewPlugin = FlutterWebviewPlugin();

  void _urlListener(String url) async {
    if (url.startsWith(redirectUri)) {
      _webviewPlugin.close();
      _twitchService.client.initializeToken(TwitchToken.fromUrl(url));
      final token =
          await _twitchService.client.twitchHttpClient.validateToken();
      if (token != null) {
        _appAuthentication.persisteToken(token);
        _navigation.clearStackAndShow(Routes.homeScreen);
      }
    }
  }

  void startAuthentication() {
    final List<TwitchApiScope> scopes = [
      TwitchApiScope.userReadFollow,
    ];
    _webviewPlugin.onUrlChanged.listen(_urlListener);

    final url = _twitchService.client.authorizeUri(scopes);
    _navigation.navigateTo(
      Routes.webViewScreen,
      arguments: WebViewScreenArguments(
        url: url.toString(),
      ),
    );
  }
}
