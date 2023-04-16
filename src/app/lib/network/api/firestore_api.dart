import 'dart:async';

import 'package:app/app/app.locator.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/network/models/event.dart';
import 'package:app/network/models/follower.dart';
import 'package:app/network/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_api_constants.dart';
import 'firestore_api_exceptions.dart';

typedef Users = List<User>;
typedef FirestoreQueryDocument = QueryDocumentSnapshot<Map<String, dynamic>>;

class FirestoreApi {
  final _appAuthentication = locator<AppAuthentication>();

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection(UsersFirestoreKey);

  Future<String?> _getUserId() async {
    return await _appAuthentication.getUserId();
  }

  // Users Collection
  Future<void> createUser(User user) async {
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

  Future<User?> getUser() async {
    final userId = await _getUserId();
    if (userId == null) return null;

    try {
      final document = await usersCollection.doc(userId).get();

      if (!document.exists) return null;
      return User.fromJson(document.data() as Map<String, dynamic>);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get user with id ${userId}',
        devDetails: '$error',
      );
    }
  }

  Future<User?> getUserById(String userId) async {
    try {
      final document = await usersCollection.doc(userId).get();

      if (!document.exists) return null;

      User user = User.fromJson(document.data() as Map<String, dynamic>);
      user.events = await getStreamerEvents(userId);

      return user;
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get user with id ${userId}',
        devDetails: '$error',
      );
    }
  }

  // Lives
  Future<Users?> fetchLives() async {
    final userId = await _getUserId();
    if (userId == null) return null;

    final collection = await usersCollection
        .doc(userId)
        .collection(FollowingFirestoreKey)
        .get();

    Users users = [];

    try {
      await Future.forEach(collection.docs,
          (QueryDocumentSnapshot<Map<String, dynamic>> element) async {
        final follower = Follower.fromJson(element.data());
        final user = await getUserById(follower.userId);
        if (user != null) users.add(user);
      });

      users.sort((a, b) => b.viewCount.compareTo(a.viewCount));
      return users;
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get following streamers',
        devDetails: '$error',
      );
    }
  }

  // Events Collection
  Future<void> createEvent(Event event) async {
    final userId = await _getUserId();
    if (userId == null) return null;

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

  Future<void> editEvent(Event event) async {
    final userId = await _getUserId();
    if (userId == null) return null;

    try {
      await usersCollection
          .doc(userId)
          .collection(EventsFirestoreKey)
          .doc(event.id)
          .update(event.toJson());
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to edit event',
        devDetails: '$error',
      );
    }
  }

  Future<List<Event>> getOwnEvents() async {
    try {
      List<Event> events = [];
      final userId = await _getUserId();
      if (userId == null) return events;

      final document = await usersCollection
          .doc(userId)
          .collection(EventsFirestoreKey)
          .orderBy('starTime')
          .where(
            'starTime',
            isGreaterThanOrEqualTo: DateTime.now().subtract(
              Duration(hours: 4), // TODO: Use duration on database instead
            ),
          )
          .get();

      await Future.forEach(
        document.docs,
        (QueryDocumentSnapshot<Map<String, dynamic>> document) {
          final event = Event.fromJson(document.data());
          event.id = document.id;
          events.add(event);
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

  Future<List<Event>> getStreamerEvents(String streamerId) async {
    try {
      List<Event> events = [];

      final document = await usersCollection
          .doc(streamerId)
          .collection(EventsFirestoreKey)
          .orderBy('starTime')
          .get();

      document.docs.forEach(
        (document) {
          events.add(Event.fromJson(document.data()));
        },
      );

      return events
          .where((element) =>
              element.finishTime.toUtc().isAfter(DateTime.now().toUtc()))
          .toList();
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to get streamer events for streamerid: $streamerId',
        devDetails: '$error',
      );
    }
  }

  // Followers Collection
  Future<User?> followStreamer(String streamerId, String username) async {
    final userId = await _getUserId();
    if (userId == null) return null;

    try {
      final streamer = Follower(
        userId: streamerId,
        username: username,
      );

      await usersCollection
          .doc(userId)
          .collection(FollowingFirestoreKey)
          .doc()
          .set(streamer.toJson());

      // TODO: Avoid calling this another request.
      return await getUserById(streamerId);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to follow streamer with id $streamerId and $username',
        devDetails: '$error',
      );
    }
  }

  Future<void> unfollowStreamer(String streamerId) async {
    final userId = await _getUserId();
    if (userId == null) return;

    try {
      final collection = await usersCollection
          .doc(userId)
          .collection(FollowingFirestoreKey)
          .where(
            'userId',
            isEqualTo: streamerId,
          )
          .get();

      collection.docs.forEach((document) {
        document.reference.delete();
      });
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to unfollow streamer with id $streamerId',
        devDetails: '$error',
      );
    }
  }

  // Following Collection
  Future<bool> isFollowingStreamer(String streamerId) async {
    final userId = await _getUserId();
    if (userId == null) return false;

    try {
      final collection = await usersCollection
          .doc(userId)
          .collection(FollowingFirestoreKey)
          .where('userId', isEqualTo: streamerId)
          .get();

      return collection.docs.isNotEmpty;
    } catch (error) {
      throw FirestoreApiException(
        message:
            'Failed to verify if user is following streamer with id $streamerId',
        devDetails: '$error',
      );
    }
  }
}
