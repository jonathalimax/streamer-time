import 'package:app/app/app.locator.dart';
import 'package:app/network/models/event.dart';
import 'package:app/network/services/event_service.dart';
import 'package:stacked/stacked.dart';

typedef Events = List<Event>;

class OwnEventsViewModel extends FutureViewModel<Events> {
  final eventService = locator<EventService>();

  @override
  Future<Events> futureToRun() async {
    return await eventService.getEvents();
  }
}
