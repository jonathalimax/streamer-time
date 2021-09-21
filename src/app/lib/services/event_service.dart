import 'package:app/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';

class EventService {
  final _firestoreApi = locator<FirestoreApi>();

  Future<void> getEvents(String userId) async {
    return null;
  }

  Future<void> getStreamerEvent(String streamerId) async {
    return null;
  }

  Future<void> getFollowingEvents(String userId) async {
    return null;
  }
}
