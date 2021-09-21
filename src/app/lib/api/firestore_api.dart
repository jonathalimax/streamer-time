import 'package:app/models/user.dart';
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

  // Agenda
  Future<void> getAgenda({required String userId}) async {
    try {
      final document = await usersCollection
          .doc(userId)
          .collection(EventsFirestoreKey)
          .get();
      print(document);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }
}
