import 'package:app/app/app.locator.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/network/api/dio_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _cachingManager = locator<CachingManager>();
  final _dioClient = locator<DioClient>();
  final _appAuthentication = locator<AppAuthentication>();
  String? deviceToken;

  Future<void> configure() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    deviceToken = await FirebaseMessaging.instance.getToken();
    FirebaseMessaging.instance.onTokenRefresh.listen(_onTokenRefresh);
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  // ignore: unused_element
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

  Future _onTokenRefresh(String token) async {
    final userId = await _appAuthentication.getUserId();
    if (userId != null) {
      await _dioClient.registerDeviceToken(userId, deviceToken!);
      await _dioClient.updateTopics(userId);
    }
  }

  Future<void> subscribeToTopic(String username) async {
    await _messaging.subscribeToTopic(username);
  }

  Future<void> unsubscribeFromTopic(String username) async {
    await _messaging.unsubscribeFromTopic(username);
  }
}
