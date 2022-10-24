import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/analytics/analytics.dart';
import 'package:app/core/notifications/push_notification_manager.dart';
import 'package:app/core/authentication/authentication_model.dart';
import 'package:app/core/constants/theme_constants.dart';
import 'package:app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    setupLocator(),
    _setupFirebase(),
    _setupHive(),
  ]);

  _setupAds();
  _setupPushNotification();
  _setupAnalytics();
  _setupRemoteConfig();
  _setupCrashlytics();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(MyApp());
}

Future<void> _setupAds() async {
  await MobileAds.instance.initialize();
}

Future<void> _setupPushNotification() async {
  await locator<PushNotificationManager>().configure();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

Future<void> _setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void _setupCrashlytics() {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
}

Future<void> _setupAnalytics() async {
  await locator<Analytics>().configure();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationModelAdapter());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await _setupFirebase();
}

Future _setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: kDebugMode ? 1 : 12),
    ),
  );

  await remoteConfig.setDefaults(
    const {
      "homeBannerUnitId": '',
      "streamerBannerUnitId": '',
      "livestreamInterstitial": '',
      "discoveryGraphicsEnabled": false,
    },
  );

  await remoteConfig.fetchAndActivate();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
      themeMode: ThemeMode.system,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed)
      locator<Analytics>().instance.logAppOpen();

    super.didChangeAppLifecycleState(state);
  }
}
