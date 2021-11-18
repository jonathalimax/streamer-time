import 'package:app/app/app.locator.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _cachingManager = locator<CachingManager>();

  Future<void> configure() async {
    final permission = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    await _setupNotificationAuthorizationCache(
      permission.authorizationStatus == AuthorizationStatus.authorized,
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => _onForegroundMessage(message),
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => _onMessageOpenedApp(message),
    );
  }

  Future<void> _setupNotificationAuthorizationCache(bool authorized) async {
    final isNotificationAuthorizedLocally =
        await _cachingManager.hasPersistedNotificationAuthoziation();

    if (!isNotificationAuthorizedLocally)
      await _cachingManager.persistNotificationPermission(authorized);
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  }

  Future<void> subscribeToTopic(String username) async {
    await _messaging.subscribeToTopic(username);
  }

  Future<void> unsubscribeFromTopic(String username) async {
    await _messaging.unsubscribeFromTopic(username);
  }
}
