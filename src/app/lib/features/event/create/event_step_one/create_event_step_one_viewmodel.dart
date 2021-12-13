import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/event/create/event_step_two/create_event_step_two_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

class CreateEventStepOneViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  void continueCreatingEvent(
    String? title,
    TwitchGame? category,
  ) {
    if (title == null || category == null) return;
    _navigationService.navigateTo(
      Routes.createEventStepTwoScreen,
      arguments: CreateEventStepTwoScreenArguments(
        viewModel: CreateEventStepTwoViewModel(
          title,
          category,
        ),
      ),
    );
  }
}
