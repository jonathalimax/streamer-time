import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';
import 'package:app/stores/streamer_store.dart';

class StreamerService {
  final _firestoreApi = locator<FirestoreApi>();
  final streamerStore = locator<StreamerStore>();

  Future fetchMyStreamers() async {
    final fetchedStreamers = await _firestoreApi.fetchMyStreamers();
    if (fetchedStreamers != null)
      streamerStore.set(
        fetchedStreamers.where((element) => element.events.isNotEmpty).toList(),
      );
  }

  Future<void> followStreamer(String streamerId) async {
    final followedStreamer = await _firestoreApi.followStreamer(streamerId);
    if (followedStreamer != null) streamerStore.add(followedStreamer);
  }

  Future<void> unfollowStreamer(String streamerId) async {
    await _firestoreApi.unfollowStreamer(streamerId);
    streamerStore.removeById(streamerId);
  }

  Future<bool> isFollowingStreamer(String streamerId) async {
    return await _firestoreApi.isFollowingStreamer(streamerId);
  }
}
