import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/user_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@singleton
class ProfileViewModel extends FutureViewModel<User?> {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _authentication = locator<AppAuthentication>();

  logout() async {
    await _authentication.logout();
    _navigation.clearStackAndShow(Routes.startupScreen);
  }

  @override
  Future<User?> futureToRun() async {
    final token = await _authentication.getTwitchToken();
    if (token == null) return null;
    if (token.userId == null) return null;
    return await _userService.getBy(id: token.userId!);
  }
}
