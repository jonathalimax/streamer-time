import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends FutureViewModel<User?> {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _authentication = locator<AppAuthentication>();
  final _cachingManager = locator<CachingManager>();

  bool _isNotificationAuthorized = false;
  bool get isNotificationAuthorized => _isNotificationAuthorized;

  logout() async {
    await _authentication.logout();
  }

  @override
  Future<User?> futureToRun() async {
    _isNotificationAuthorized =
        await _cachingManager.isNotificationAuthorized();
    return await _userService.getUserData();
  }

  void showFavorites() {
    _navigation.navigateTo(Routes.favoritesScreen);
  }

  void showEvents() {
    _navigation.navigateTo(Routes.ownEventsScreen);
  }

  Future<void> setNotificationEnable(bool isEnabled) async {
    _isNotificationAuthorized = isEnabled;
    await _cachingManager.persistNotificationPermission(isEnabled);
    notifyListeners();
  }
}
