import 'package:app/app/app.locator.dart';
import 'package:app/core/authentication/authentication_model.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:twitch_api/twitch_api.dart';

class AppAuthentication {
  final _cachingManager = locator<CachingManager>();
  final firebaseAuth = FirebaseAuth.instance;

  Future<void> persistToken(TwitchToken token) async {
    final authToken = AuthenticationModel.fromToken(token);
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(AUTH_TOKEN_KEY, authToken);
    await encryptedBox.close();

    await firebaseAuth.signInAnonymously();
  }

  Future<bool> isAuthenticated() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken = encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    await encryptedBox.close();

    if (authToken == null) return false;
    return authToken.expiresIn != 0;
  }

  Future logout() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.delete(AUTH_TOKEN_KEY);
    await encryptedBox.close();

    await firebaseAuth.signOut();
  }

  Future<TwitchToken?> getTwitchToken() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return null;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken =
        await encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    await encryptedBox.close();

    if (authToken == null) return null;

    return authToken.twitchToken;
  }
}
