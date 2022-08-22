import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';

class StreamerService {
  final _firestoreApi = locator<FirestoreApi>();
  Users? streamers;

  Future<Users?> fetchMyStreamers() async {
    final fetchedStreamers = await _firestoreApi.fetchMyStreamers();
    streamers = fetchedStreamers;
    return fetchedStreamers;
  }

  Future<void> followStreamer(String streamerId) async {
    final followedStreamer = await _firestoreApi.followStreamer(streamerId);
    if (followedStreamer != null) streamers?.add(followedStreamer);
  }

  Future<void> unfollowStreamer(String streamerId) async {
    await _firestoreApi.unfollowStreamer(streamerId);
    streamers?.removeWhere((element) => element.id == streamerId);
  }

  Future<bool> isFollowingStreamer(String streamerId) async {
    return await _firestoreApi.isFollowingStreamer(streamerId);
  }
}
