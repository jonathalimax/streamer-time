import 'package:app/app/app.locator.dart';
import 'package:app/features/startup/startup_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void runAnimation() {
    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        _navigationService.navigateToView(
          StartupScreen(),
          transitionStyle: Transition.fade,
        );
      },
    );
  }
}
