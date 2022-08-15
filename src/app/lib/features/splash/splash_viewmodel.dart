import 'package:app/app/app.locator.dart';
import 'package:app/features/startup/startup_screen.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firestoreApi = locator<FirestoreApi>();
  final _streamerService = locator<StreamerService>();

  SplashViewModel() {
    _firestoreApi.followingStreamers.listen(_onUsersUpdated);
  }

  void _onUsersUpdated(Users users) {
    _streamerService.streamers = users;

    _navigationService.replaceWithTransition(
      StartupScreen(),
      transitionStyle: Transition.fade,
    );
  }
}
