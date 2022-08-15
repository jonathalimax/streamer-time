import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

const String SECURE_TOKEN_KEY = 'SecureKey';
const String AUTH_BOX_KEY = 'AuthenticationBox';
const String AUTH_TOKEN_KEY = 'authToken';
const String SETTINGS_BOX_KEY = 'SettingsBox';
const String NOTIFICATION_AUTHORIZED_KEY = 'NotificationAuthorizedKey';

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

  Future<void> persistNotificationPermission(bool isAuthorized) async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return;

    final encryptedBox = await Hive.openBox(
      SETTINGS_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(NOTIFICATION_AUTHORIZED_KEY, isAuthorized);
    await encryptedBox.close();
  }

  Future<bool> isNotificationAuthorized() async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      SETTINGS_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final isAuthorized = encryptedBox.get(NOTIFICATION_AUTHORIZED_KEY) as bool?;
    await encryptedBox.close();

    if (isAuthorized == null) return false;
    return isAuthorized;
  }

  Future<bool> hasPersistedNotificationAuthoziation() async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      SETTINGS_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final isAuthorized = encryptedBox.get(NOTIFICATION_AUTHORIZED_KEY) as bool?;
    await encryptedBox.close();

    return isAuthorized != null;
  }
}
