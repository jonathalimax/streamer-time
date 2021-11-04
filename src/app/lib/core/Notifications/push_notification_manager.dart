import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> configure() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    String? token = await _messaging.getToken();
    print(token);

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) => _onForegroundMessage(message),
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => _onMessageOpenedApp(message),
    );
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
