import 'package:design_system/styles/app_colors.dart';
import 'package:design_system/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ThemeConstants {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: kcPurple,
    colorScheme: ColorScheme.light(
      secondary: kcLightPurple,
    ),
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
    snackBarTheme: SnackBarThemeData(
      backgroundColor: kcPurple,
      contentTextStyle: TextStyle(
        color: kcIceWhite,
      ),
      behavior: SnackBarBehavior.fixed,
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: kcLightPurple,
    colorScheme: ColorScheme.dark(
      secondary: kcPurple,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: 'Nunito',
    appBarTheme: AppBarTheme(
      color: kcPurple,
      elevation: 2,
      iconTheme: IconThemeData(color: kcIceWhite),
      actionsIconTheme: IconThemeData(color: kcIceWhite),
      titleTextStyle: ktsHeading4Style.copyWith(
        color: kcIceWhite,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: kcLightPurple,
      contentTextStyle: TextStyle(
        color: kcIceWhite,
      ),
      behavior: SnackBarBehavior.fixed,
    ),
  );
}
