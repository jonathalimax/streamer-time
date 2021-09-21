import 'package:app/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';
import 'package:app/models/user.dart';

class UserService {
  final _firestoreApi = locator<FirestoreApi>();

  User? _currentUser;

  User get currentUser => _currentUser!;

  Future<void> createOrUpdate({required User user}) async {
    await _firestoreApi.createUser(user: user);
  }
}
