import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';

class StreamerService {
  final _firestoreApi = locator<FirestoreApi>();
  Users? streamers;

  Future<void> followStreamer(String streamerId) async {
    return await _firestoreApi.followStreamer(streamerId);
  }

  Future<void> unfollowStreamer(String streamerId) async {
    return await _firestoreApi.unfollowStreamer(streamerId);
  }

  Future<bool> isFollowingStreamer(String streamerId) async {
    return await _firestoreApi.isFollowingStreamer(streamerId);
  }
}
