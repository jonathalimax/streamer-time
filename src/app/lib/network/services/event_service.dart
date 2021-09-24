import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';
import 'package:app/network/models/event.dart';

class EventService {
  final _firestoreApi = locator<FirestoreApi>();

  Future<void> create({
    required String userId,
    required Event event,
  }) async {
    return await _firestoreApi.createEvent(
      userId: userId,
      event: event,
    );
  }

  Future<List<Event>> getEvents(String userId) async {
    return await _firestoreApi.getOwnEvents(userId: userId);
  }

  Future<void> getStreamerEvent(String streamerId) async {
    return null;
  }

  Future<void> getFollowingEvents(String userId) async {
    return null;
  }
}
