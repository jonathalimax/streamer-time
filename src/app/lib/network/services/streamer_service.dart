import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';

class StreamerService {
  final _firestoreApi = locator<FirestoreApi>();
  Users? streamers;

  Future<Users?> fetchMyStreamers() async {
    streamers = await _firestoreApi.fetchMyStreamers();
    return streamers;
  }

  Future<void> followStreamer(String streamerId) async {
    await _firestoreApi.followStreamer(streamerId);
    await fetchMyStreamers();
  }

  Future<void> unfollowStreamer(String streamerId) async {
    await _firestoreApi.unfollowStreamer(streamerId);
    streamers?.removeWhere((element) => element.id == streamerId);
  }

  Future<bool> isFollowingStreamer(String streamerId) async {
    return await _firestoreApi.isFollowingStreamer(streamerId);
  }
}
