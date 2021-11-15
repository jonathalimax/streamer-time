// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../features/agenda/agenda_screen.dart';
import '../features/channels/channels_screen.dart';
import '../features/create_event/event_step_one/create_event_step_one_screen.dart';
import '../features/create_event/event_step_two/create_event_step_two_screen.dart';
import '../features/create_event/event_step_two/create_event_step_two_viewmodel.dart';
import '../features/discover/discover_screen.dart';
import '../features/home/home_screen.dart';
import '../features/login/login_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/splash/splash_screen.dart';
import '../features/startup/startup_screen.dart';
import '../features/streamer/streamer_screen.dart';
import '../features/streamer/streamer_viewmodel.dart';
import '../features/webview/webview_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String startupScreen = '/startup-screen';
  static const String loginScreen = '/login-screen';
  static const String homeScreen = '/home-screen';
  static const String webViewScreen = '/web-view-screen';
  static const String agendaScreen = '/agenda-screen';
  static const String discoverScreen = '/discover-screen';
  static const String profileScreen = '/profile-screen';
  static const String streamerScreen = '/streamer-screen';
  static const String channelsScreen = '/channels-screen';
  static const String createEventStepOneScreen =
      '/create-event-step-one-screen';
  static const String createEventStepTwoScreen =
      '/create-event-step-two-screen';
  static const all = <String>{
    splashScreen,
    startupScreen,
    loginScreen,
    homeScreen,
    webViewScreen,
    agendaScreen,
    discoverScreen,
    profileScreen,
    streamerScreen,
    channelsScreen,
    createEventStepOneScreen,
    createEventStepTwoScreen,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.startupScreen, page: StartupScreen),
    RouteDef(Routes.loginScreen, page: LoginScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.webViewScreen, page: WebViewScreen),
    RouteDef(Routes.agendaScreen, page: AgendaScreen),
    RouteDef(Routes.discoverScreen, page: DiscoverScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.streamerScreen, page: StreamerScreen),
    RouteDef(Routes.channelsScreen, page: ChannelsScreen),
    RouteDef(Routes.createEventStepOneScreen, page: CreateEventStepOneScreen),
    RouteDef(Routes.createEventStepTwoScreen, page: CreateEventStepTwoScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    SplashScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SplashScreen(),
        settings: data,
      );
    },
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
        builder: (context) => WebViewScreen(
          args.url,
          args.shouldNavigate,
        ),
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
    ProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProfileScreen(),
        settings: data,
      );
    },
    StreamerScreen: (data) {
      var args = data.getArgs<StreamerScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => StreamerScreen(
          key: args.key,
          viewModel: args.viewModel,
        ),
        settings: data,
      );
    },
    ChannelsScreen: (data) {
      var args = data.getArgs<ChannelsScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChannelsScreen(
          args.game,
          args.gameId,
          key: args.key,
        ),
        settings: data,
      );
    },
    CreateEventStepOneScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateEventStepOneScreen(),
        settings: data,
      );
    },
    CreateEventStepTwoScreen: (data) {
      var args = data.getArgs<CreateEventStepTwoScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => CreateEventStepTwoScreen(
          key: args.key,
          viewModel: args.viewModel,
        ),
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
  final Future<bool> Function(String) shouldNavigate;
  WebViewScreenArguments({required this.url, required this.shouldNavigate});
}

/// StreamerScreen arguments holder class
class StreamerScreenArguments {
  final Key? key;
  final StreamerViewModel viewModel;
  StreamerScreenArguments({this.key, required this.viewModel});
}

/// ChannelsScreen arguments holder class
class ChannelsScreenArguments {
  final String game;
  final String gameId;
  final Key? key;
  ChannelsScreenArguments({required this.game, required this.gameId, this.key});
}

/// CreateEventStepTwoScreen arguments holder class
class CreateEventStepTwoScreenArguments {
  final Key? key;
  final CreateEventStepTwoViewModel viewModel;
  CreateEventStepTwoScreenArguments({this.key, required this.viewModel});
}
