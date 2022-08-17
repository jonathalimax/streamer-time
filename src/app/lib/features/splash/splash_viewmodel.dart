import 'package:app/app/app.locator.dart';
import 'package:app/features/startup/startup_screen.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  Future<void> fetchStreamers() async {
    final streamers = await _streamerService.fetchMyStreamers();

    if (streamers == null) {
      await Future.delayed(Duration(seconds: 3));
    }

    _navigationService.replaceWithTransition(
      StartupScreen(),
      transitionStyle: Transition.fade,
      duration: Duration(milliseconds: 300),
    );
  }
}
