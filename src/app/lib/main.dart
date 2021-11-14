import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/notifications/push_notification_manager.dart';
import 'package:app/core/authentication/authentication_model.dart';
import 'package:app/core/constants/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await _setupHive();
  await _setupFirebase();
  await _setupAds();
  await _setupPushNotification();
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
  await Firebase.initializeApp();
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationModelAdapter());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeConstants.lightTheme,
      darkTheme: ThemeConstants.darkTheme,
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
