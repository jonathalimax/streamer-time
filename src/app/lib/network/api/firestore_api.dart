import 'package:app/network/models/event.dart';
import 'package:app/network/models/follower.dart';
import 'package:app/network/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_api_constants.dart';
import 'firestore_api_exceptions.dart';

class FirestoreApi {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(UsersFirestoreKey);

  // Users Collection
  Future<void> createUser({required User user}) async {
    try {
      final document = usersCollection.doc(user.id);
      await document.set(user.toJson());
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }

  Future<User?> getUser({required String id}) async {
    try {
      final document = await usersCollection.doc(id).get();
      if (!document.exists) return null;
      return User.fromJson(document.data() as Map<String, dynamic>);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get user with id ${id}',
        devDetails: '$error',
      );
    }
  }

  // Events Collection
  Future<void> createEvent({
    required String userId,
    required Event event,
  }) async {
    try {
      await usersCollection
          .doc(userId)
          .collection(EventsFirestoreKey)
          .doc()
          .set(event.toJson());
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new event',
        devDetails: '$error',
      );
    }
  }

  Future<List<Event>> getOwnEvents({required String userId}) async {
    try {
      List<Event> events = [];
      final document = await usersCollection
          .doc(userId)
          .collection(EventsFirestoreKey)
          .get();

      document.docs.forEach(
        (document) {
          events.add(Event.fromJson(document.data()));
        },
      );

      return events;
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get own events',
        devDetails: '$error',
      );
    }
  }

  // Followers Collection
  Future<void> followStreamer({
    required String userId,
    required String streamerId,
  }) async {
    try {
      final DocumentReference streamerRef =
          FirebaseFirestore.instance.doc('$UsersFirestoreKey/$streamerId');
      final streamer = Follower(userRef: streamerRef);
      await usersCollection
          .doc(userId)
          .collection(FollowingFirestoreKey)
          .doc()
          .set(streamer.toJson());
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to follow streamer with id $streamerId',
        devDetails: '$error',
      );
    }
  }

  Future<List<User>> getFollowingStreamers({
    required String userId,
  }) async {
    try {
      List<User> users = [];
      final collection = await usersCollection
          .doc(userId)
          .collection(FollowingFirestoreKey)
          .get();

      await Future.forEach(collection.docs,
          (QueryDocumentSnapshot<Map<String, dynamic>> document) async {
        final follower = Follower.fromJson(document.data());
        final user = await follower.userRef.get();

        users.add(User.fromJson(user.data() as Map<String, dynamic>));
      });

      return users;
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get following streamers',
        devDetails: '$error',
      );
    }
  }
}
