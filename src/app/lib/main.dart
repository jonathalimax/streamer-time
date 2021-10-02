import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/authentication/authentication_model.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/styles/app_text_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked_services/stacked_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  Hive.registerAdapter(AuthenticationModelAdapter());
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData(
    primaryColor: kcPurple,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Nunito',
    appBarTheme: AppBarTheme(
      color: kcLightPurple,
      elevation: 2,
      iconTheme: IconThemeData(color: kcIceWhite),
      actionsIconTheme: IconThemeData(color: kcIceWhite),
      titleTextStyle: ktsHeading4Style.copyWith(
        color: kcIceWhite,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          secondary: kcLightPurple,
        ),
      ),
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
