import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

typedef Users = List<User>?;

@singleton
class AgendaViewModel extends FutureViewModel<Users> {
  final _navigation = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  @override
  Future<Users> futureToRun() async {
    return await _getFollowedStreamers();
  }

  Future<Users> _getFollowedStreamers() async {
    return await _streamerService.getFollowingStreamers();
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventDateScreen);
  }
}
