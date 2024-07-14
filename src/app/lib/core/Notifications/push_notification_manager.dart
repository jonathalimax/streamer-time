import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/analytics/analytics.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/core/notifications/notification_data.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/firebase_options.dart';
import 'package:app/network/api/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked_services/stacked_services.dart';

class PushNotificationManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _cachingManager = locator<CachingManager>();
  final _dioClient = locator<DioClient>();
  final _appAuthentication = locator<AppAuthentication>();
  final _navigationService = locator<NavigationService>();
  final _analytics = locator<Analytics>();

  Future<void> configure() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken != null) _cachingManager.persistDeviceToken(deviceToken);
    print('DEBUG:::FirebaseMessaging device token $deviceToken');

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
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

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print("DEBUG::: _onBackgroundMessage $message");
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    print('DEBUG::: _onForegroundMessage $message');
    print('Message data: ${message.data}');
  }

  Future<void> _onMessageOpenedApp(RemoteMessage message) async {
    print('DEBUG::: _onMessageOpenedApp $message');
    print('Message data: ${message.data}');

    handleNotification(message);
  }

  Future _onTokenRefresh(String token) async {
    final userId = await _appAuthentication.getUserId();
    if (userId != null) {
      await _cachingManager.persistDeviceToken(token);
      await _dioClient.registerDeviceToken(userId, token);
      await _dioClient.updateTopics(userId);
    }
  }

  Future<void> subscribeToTopic(String username) async {
    await _messaging.subscribeToTopic(username);
  }

  Future<void> unsubscribeFromTopic(String username) async {
    await _messaging.unsubscribeFromTopic(username);
  }

  Future<void> handleNotification(RemoteMessage message) async {
    final data = NotificationData.fromJson(message.data);

    switch (data.type) {
      case 'live':
        await _navigationService.navigateTo(
          Routes.streamerScreen,
          arguments: StreamerScreenArguments(
            viewModel: StreamerViewModel(
              streamerId: data.streamerId,
              username: data.username,
            ),
            shouldOpenLiveOnStart: true,
          ),
        );
    }

    _analytics.instance.logEvent(
      name: 'notification_open',
      parameters: {
        'streamerId': data.streamerId,
        'streamName': data.username,
        'type': data.type,
      },
    );
  }
}
