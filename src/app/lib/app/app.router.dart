// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../features/agenda/agenda_screen.dart';
import '../features/discover/discover_screen.dart';
import '../features/home/home_screen.dart';
import '../features/login/login_screen.dart';
import '../features/startup/startup_screen.dart';
import '../features/webview/webview_screen.dart';

class Routes {
  static const String startupScreen = '/';
  static const String loginScreen = '/login-screen';
  static const String homeScreen = '/home-screen';
  static const String webViewScreen = '/web-view-screen';
  static const String agendaScreen = '/agenda-screen';
  static const String discoverScreen = '/discover-screen';
  static const all = <String>{
    startupScreen,
    loginScreen,
    homeScreen,
    webViewScreen,
    agendaScreen,
    discoverScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupScreen, page: StartupScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.webViewScreen, page: WebViewScreen),
    RouteDef(Routes.agendaScreen, page: AgendaScreen),
    RouteDef(Routes.discoverScreen, page: DiscoverScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    WebViewScreen: (data) {
      var args = data.getArgs<WebViewScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => WebViewScreen(args.url),
        settings: data,
      );
    },
    AgendaScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AgendaScreen(),
        settings: data,
      );
    },
    DiscoverScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const DiscoverScreen(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// WebViewScreen arguments holder class
class WebViewScreenArguments {
  final String url;
  WebViewScreenArguments({required this.url});
}
