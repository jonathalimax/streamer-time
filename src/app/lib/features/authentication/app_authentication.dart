import 'dart:convert';
import 'dart:typed_data';

import 'package:app/features/authentication/authentication_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:twitch_api/twitch_api.dart';

const String AUTH_BOX_KEY = 'AuthenticationBox';
const String AUTH_TOKEN_KEY = 'authToken';
const String SECURE_TOKEN_KEY = 'SecureToken';

class AppAuthentication {
  persisteToken(TwitchToken token) async {
    final authToken = AuthenticationModel.fromToken(token);
    final encryptionKey = await _getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(AUTH_TOKEN_KEY, authToken);
    encryptedBox.close();
  }

  Future<bool> isAuthenticated() async {
    final encryptionKey = await _getEncryptionKey();

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
    final encryptionKey = await _getEncryptionKey();

    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.delete(AUTH_TOKEN_KEY);
    encryptedBox.close();
  }

  Future<TwitchToken?> getTwitchToken() async {
    final encryptionKey = await _getEncryptionKey();

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

  Future<Uint8List?> _getEncryptionKey() async {
    final secureStorage = const FlutterSecureStorage();
    final containsEncryptionKey =
        await secureStorage.containsKey(key: SECURE_TOKEN_KEY);

    if (!containsEncryptionKey) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: SECURE_TOKEN_KEY,
        value: base64UrlEncode(key),
      );
    }

    final secureToken = await secureStorage.read(
      key: SECURE_TOKEN_KEY,
    );

    if (secureToken == null) return null;

    return base64Url.decode(secureToken);
  }
}
