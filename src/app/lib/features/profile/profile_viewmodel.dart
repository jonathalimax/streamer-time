import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/user_service.dart';
import 'package:app/widgets/card_game/card_game_list_viewmodel.dart';
import 'package:app/widgets/card_streams/card_stream_list_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends FutureViewModel<User?> {
  final _navigation = locator<NavigationService>();
  final _userService = locator<UserService>();
  final _authentication = locator<AppAuthentication>();

  logout() async {
    locator.resetLazySingleton<AgendaViewModel>();
    locator.resetLazySingleton<DiscoverViewmodel>();
    locator.resetLazySingleton<ProfileViewModel>();
    locator.resetLazySingleton<CardStreamListViewModel>();
    locator.resetLazySingleton<CardGameListViewModel>();
    await _authentication.logout();
    await _navigation.clearStackAndShow(Routes.startupScreen);
  }

  @override
  Future<User?> futureToRun() async {
    return await _userService.getUserData();
  }
}
