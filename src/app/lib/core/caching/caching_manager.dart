import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

const String SECURE_TOKEN_KEY = 'SecureKey';
const String AUTH_BOX_KEY = 'AuthenticationBox';
const String SETTINGS_BOX_KEY = 'SettingsBox';
const String AUTH_TOKEN_KEY = 'authToken';
const String NOTIFICATION_AUTHORIZED_KEY = 'NotificationAuthorizedKey';
const String OPENED_LIVES_AMOUNT = 'OpenedLivesAmount';
const String DEVICE_TOKEN = "DeviceToken";

class CachingManager {
  Future<Uint8List?> getEncryptionKey() async {
    final secureStorage = const FlutterSecureStorage();

    final secureToken = await secureStorage.read(
      key: SECURE_TOKEN_KEY,
    );

    if (secureToken == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: SECURE_TOKEN_KEY,
        value: base64UrlEncode(key),
      );

      return base64Url.decode(base64UrlEncode(key));
    } else {
      return base64Url.decode(secureToken);
    }
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

  Future<bool> shouldAppearFullAd() async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      OPENED_LIVES_AMOUNT,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final openedLivesAmount = encryptedBox.get(OPENED_LIVES_AMOUNT) as int?;
    await encryptedBox.close();

    return openedLivesAmount != null && openedLivesAmount >= 3;
  }

  Future incrementLivesOpened() async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      OPENED_LIVES_AMOUNT,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    int openedLivesAmount = encryptedBox.get(OPENED_LIVES_AMOUNT) ?? 0;
    await encryptedBox.put(
      OPENED_LIVES_AMOUNT,
      openedLivesAmount >= 3 ? 0 : ++openedLivesAmount,
    );
    await encryptedBox.close();
  }

  Future persistDeviceToken(String deviceToken) async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return false;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    await encryptedBox.put(DEVICE_TOKEN, deviceToken);
    await encryptedBox.close();
  }

  Future<String?> getDeviceToken() async {
    final encryptionKey = await getEncryptionKey();
    if (encryptionKey == null) return null;

    final encryptedBox = await Hive.openBox(
      AUTH_BOX_KEY,
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    final deviceToken = await encryptedBox.get(DEVICE_TOKEN);
    await encryptedBox.close();

    return deviceToken;
  }
}
