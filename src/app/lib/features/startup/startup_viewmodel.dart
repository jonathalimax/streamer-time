import 'package:app/app/app.locator.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/features/home/home_screen.dart';
import 'package:app/features/login/login_screen.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _twithService = locator<TwitchService>();
  final _appAuthentication = locator<AppAuthentication>();

  Future<void> runStartupLogic() async {
    final token = await _appAuthentication.getTwitchToken();
    final isAuthenticated = await _appAuthentication.isAuthenticated();

    if (token != null) {}

    if (isAuthenticated && token != null) {
      _twithService.client.initializeToken(token);

      _navigation.replaceWithTransition(
        HomeScreen(),
        transitionStyle: Transition.fade,
        duration: Duration(milliseconds: 300),
      );
    } else {
      _navigation.navigateWithTransition(
        LoginScreen(),
        transitionStyle: Transition.fade,
        duration: Duration(milliseconds: 300),
      );
    }
  }
}
