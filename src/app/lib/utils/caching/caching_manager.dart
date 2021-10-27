import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

const String SECURE_TOKEN_KEY = 'SecureToken';
const String AUTH_BOX_KEY = 'AuthenticationBox';
const String AUTH_TOKEN_KEY = 'authToken';
const String SETTINGS_BOX_KEY = 'SettingsBox';
const String SETTINGS_DARK_MODE_KEY = 'settingsDarkMode';

class CachingManager {
  Future<Uint8List?> getEncryptionKey() async {
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
