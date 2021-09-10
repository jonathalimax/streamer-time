import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class ProfileViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _authentication = locator<AppAuthentication>();

  logout() async {
    await _authentication.logout();
    _navigation.clearStackAndShow(Routes.startupScreen);
  }
}
