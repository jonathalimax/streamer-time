import "package:app/network/api/firestore_api.dart";
import "package:app/app/app.locator.dart";
import "package:app/network/models/event.dart";

class EventService {
  final _firestoreApi = locator<FirestoreApi>();

  Future<void> createEvent(Event event) async {
    return await _firestoreApi.createEvent(event);
  }

  Future<void> editEvent(Event event) async {
    return await _firestoreApi.editEvent(event);
  }

  Future<List<Event>> getEvents() async {
    return await _firestoreApi.getOwnEvents();
  }

  Future<List<Event>> getStreamerEvents(String streamerId) async {
    return await _firestoreApi.getStreamerEvents(streamerId);
  }
}
