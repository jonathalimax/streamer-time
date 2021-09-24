import 'package:app/network/api/firestore_api.dart';
import 'package:app/app/app.locator.dart';
import 'package:app/network/models/user.dart';

class UserService {
  final _firestoreApi = locator<FirestoreApi>();

  Future<void> createOrUpdate({required User user}) async {
    return await _firestoreApi.createUser(user: user);
  }

  Future<User?> getBy({required String id}) async {
    return await _firestoreApi.getUser(id: id);
  }
}
