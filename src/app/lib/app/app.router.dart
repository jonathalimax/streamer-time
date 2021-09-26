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
import '../features/discover/discover_screen.dart';
import '../features/event/event_date/create_event_date_screen.dart';
import '../features/event/event_time/create_event_time_screen.dart';
import '../features/home/home_screen.dart';
import '../features/login/login_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/startup/startup_screen.dart';
import '../features/streamer/streamer_screen.dart';
import '../features/streamer/streamer_viewmodel.dart';
import '../features/webview/webview_screen.dart';

class Routes {
  static const String startupScreen = '/';
  static const String loginScreen = '/login-screen';
  static const String homeScreen = '/home-screen';
  static const String webViewScreen = '/web-view-screen';
  static const String agendaScreen = '/agenda-screen';
  static const String discoverScreen = '/discover-screen';
  static const String profileScreen = '/profile-screen';
  static const String streamerScreen = '/streamer-screen';
  static const String channelsScreen = '/channels-screen';
  static const String createEventDateScreen = '/create-event-date-screen';
  static const String createEventTimeScreen = '/create-event-time-screen';
  static const all = <String>{
    startupScreen,
    loginScreen,
    homeScreen,
    webViewScreen,
    agendaScreen,
    discoverScreen,
    profileScreen,
    streamerScreen,
    channelsScreen,
    createEventDateScreen,
    createEventTimeScreen,
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
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.streamerScreen, page: StreamerScreen),
    RouteDef(Routes.channelsScreen, page: ChannelsScreen),
    RouteDef(Routes.createEventDateScreen, page: CreateEventDateScreen),
    RouteDef(Routes.createEventTimeScreen, page: CreateEventTimeScreen),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => StartupScreen(),
        settings: data,
      );
    },
    LoginScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => LoginScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => HomeScreen(),
        settings: data,
      );
    },
    WebViewScreen: (data) {
      var args = data.getArgs<WebViewScreenArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => WebViewScreen(
          args.url,
          args.shouldNavigate,
        ),
        settings: data,
      );
    },
    AgendaScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => AgendaScreen(),
        settings: data,
      );
    },
    DiscoverScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const DiscoverScreen(),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const ProfileScreen(),
        settings: data,
      );
    },
    StreamerScreen: (data) {
      var args = data.getArgs<StreamerScreenArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => StreamerScreen(
          key: args.key,
          viewModel: args.viewModel,
        ),
        settings: data,
      );
    },
    ChannelsScreen: (data) {
      var args = data.getArgs<ChannelsScreenArguments>(nullOk: false);
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => ChannelsScreen(
          args.game,
          args.gameId,
          key: args.key,
        ),
        settings: data,
      );
    },
    CreateEventDateScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const CreateEventDateScreen(),
        settings: data,
      );
    },
    CreateEventTimeScreen: (data) {
      return MaterialPageRoute<MaterialRoute<dynamic>>(
        builder: (context) => const CreateEventTimeScreen(),
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
