import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/event/edit/step_one/event_step_one_edit_viewmodel.dart';
import 'package:app/network/models/event.dart';
import 'package:app/network/services/event_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

typedef Events = List<Event>;

class OwnEventsViewModel extends FutureViewModel<Events> {
  final eventService = locator<EventService>();
  final _navigation = locator<NavigationService>();

  @override
  Future<Events> futureToRun() async {
    return await eventService.getEvents();
  }

  void manageEvent(Event event) {
    _navigation
        .navigateTo(
      Routes.eventStepOneEditScreen,
      arguments: EventStepOneEditScreenArguments(
        viewModel: EventStepOneEditViewModel(event),
      ),
    )
        ?.then(
      (_) async {
        await futureToRun();
        notifyListeners();
      },
    );
  }
}
