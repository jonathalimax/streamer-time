import 'package:app/features/authentication/authentication_model.dart';
import 'package:app/utils/caching/caching_manager.dart';
import 'package:hive/hive.dart';
import 'package:twitch_api/twitch_api.dart';

class AppAuthentication {
  final _cachingManager = CachingManager();

  persisteToken(TwitchToken token) async {
    final authToken = AuthenticationModel.fromToken(token);
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(AUTH_TOKEN_KEY, authToken);
    encryptedBox.close();
  }

  Future<bool> isAuthenticated() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken = encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    encryptedBox.close();

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
    encryptedBox.close();
  }

  Future<TwitchToken?> getTwitchToken() async {
    final encryptionKey = await _cachingManager.getEncryptionKey();

    if (encryptionKey == null) return null;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final authToken = encryptedBox.get(AUTH_TOKEN_KEY) as AuthenticationModel?;
    encryptedBox.close();

    if (authToken == null) return null;

    return authToken.twitchToken;
  }
}
