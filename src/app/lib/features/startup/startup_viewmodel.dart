import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _appAuthentication = locator<AppAuthentication>();

  Future<void> runStartupLogic() async {
    final authenticated = await _appAuthentication.isAuthenticated();
    authenticated
        ? _navigation.replaceWith(Routes.homeScreen)
        : _navigation.replaceWith(Routes.loginScreen);
  }
}
