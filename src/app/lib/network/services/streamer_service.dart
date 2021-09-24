import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';
import 'package:app/network/models/user.dart';

class StreamerService {
  final _firestoreApi = locator<FirestoreApi>();

  Future<void> followStreamer({
    required String userId,
    required String streamerId,
  }) async {
    return await _firestoreApi.followStreamer(
      userId: userId,
      streamerId: streamerId,
    );
  }

  Future<List<User>> getFollowingStreamers({required String userId}) async {
    return await _firestoreApi.getFollowingStreamers(userId: userId);
  }
}
