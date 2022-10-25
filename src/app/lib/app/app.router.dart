// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, unused_import, non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/channels/channels_screen.dart';
import '../features/discover/discover_screen.dart';
import '../features/event/create/event_step_one/create_event_step_one_screen.dart';
import '../features/event/create/event_step_two/create_event_step_two_screen.dart';
import '../features/event/create/event_step_two/create_event_step_two_viewmodel.dart';
import '../features/event/edit/step_one/event_step_one_edit_screen.dart';
import '../features/event/edit/step_one/event_step_one_edit_viewmodel.dart';
import '../features/event/edit/step_two/event_step_two_edit_screen.dart';
import '../features/event/edit/step_two/event_step_two_edit_viewmodel.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/lives/lives_screen.dart';
import '../features/login/login_screen.dart';
import '../features/own_events/own_events_screen.dart';
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
  static const String livesScreen = '/lives-screen';
  static const String discoverScreen = '/discover-screen';
  static const String profileScreen = '/profile-screen';
  static const String streamerScreen = '/streamer-screen';
  static const String channelsScreen = '/channels-screen';
  static const String createEventStepOneScreen =
      '/create-event-step-one-screen';
  static const String createEventStepTwoScreen =
      '/create-event-step-two-screen';
  static const String eventStepOneEditScreen = '/event-step-one-edit-screen';
  static const String eventStepTwoEditScreen = '/event-step-two-edit-screen';
  static const String favoritesScreen = '/favorites-screen';
  static const String ownEventsScreen = '/own-events-screen';
  static const all = <String>{
    startupScreen,
    loginScreen,
    homeScreen,
    webViewScreen,
    livesScreen,
    discoverScreen,
    profileScreen,
    streamerScreen,
    channelsScreen,
    createEventStepOneScreen,
    createEventStepTwoScreen,
    eventStepOneEditScreen,
    eventStepTwoEditScreen,
    favoritesScreen,
    ownEventsScreen,
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
    RouteDef(Routes.livesScreen, page: LivesScreen),
    RouteDef(Routes.discoverScreen, page: DiscoverScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.streamerScreen, page: StreamerScreen),
    RouteDef(Routes.channelsScreen, page: ChannelsScreen),
    RouteDef(Routes.createEventStepOneScreen, page: CreateEventStepOneScreen),
    RouteDef(Routes.createEventStepTwoScreen, page: CreateEventStepTwoScreen),
    RouteDef(Routes.eventStepOneEditScreen, page: EventStepOneEditScreen),
    RouteDef(Routes.eventStepTwoEditScreen, page: EventStepTwoEditScreen),
    RouteDef(Routes.favoritesScreen, page: FavoritesScreen),
    RouteDef(Routes.ownEventsScreen, page: OwnEventsScreen),
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
        builder: (context) => WebViewScreen(
          args.url,
          args.shouldNavigate,
        ),
        settings: data,
      );
    },
    LivesScreen: (data) {
      var args = data.getArgs<LivesScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => LivesScreen(
          key: args.key,
          changePage: args.changePage,
        ),
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
          shouldOpenLiveOnStart: args.shouldOpenLiveOnStart,
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
    EventStepOneEditScreen: (data) {
      var args = data.getArgs<EventStepOneEditScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EventStepOneEditScreen(
          key: args.key,
          viewModel: args.viewModel,
        ),
        settings: data,
      );
    },
    EventStepTwoEditScreen: (data) {
      var args = data.getArgs<EventStepTwoEditScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => EventStepTwoEditScreen(
          key: args.key,
          viewModel: args.viewModel,
        ),
        settings: data,
      );
    },
    FavoritesScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const FavoritesScreen(),
        settings: data,
      );
    },
    OwnEventsScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const OwnEventsScreen(),
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

/// LivesScreen arguments holder class
class LivesScreenArguments {
  final Key? key;
  final void Function(TabItem) changePage;
  LivesScreenArguments({this.key, required this.changePage});
}

/// StreamerScreen arguments holder class
class StreamerScreenArguments {
  final Key? key;
  final StreamerViewModel viewModel;
  final bool shouldOpenLiveOnStart;
  StreamerScreenArguments(
      {this.key, required this.viewModel, this.shouldOpenLiveOnStart = false});
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

/// EventStepOneEditScreen arguments holder class
class EventStepOneEditScreenArguments {
  final Key? key;
  final EventStepOneEditViewModel viewModel;
  EventStepOneEditScreenArguments({this.key, required this.viewModel});
}

/// EventStepTwoEditScreen arguments holder class
class EventStepTwoEditScreenArguments {
  final Key? key;
  final EventStepTwoEditViewModel viewModel;
  EventStepTwoEditScreenArguments({this.key, required this.viewModel});
}

/// ************************************************************************
/// Extension for strongly typed navigation
/// *************************************************************************

extension NavigatorStateExtension on NavigationService {
  Future<dynamic> navigateToStartupScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.startupScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLoginScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.loginScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToHomeScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.homeScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToWebViewScreen({
    required String url,
    required Future<bool> Function(String) shouldNavigate,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.webViewScreen,
      arguments:
          WebViewScreenArguments(url: url, shouldNavigate: shouldNavigate),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToLivesScreen({
    Key? key,
    required void Function(TabItem) changePage,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.livesScreen,
      arguments: LivesScreenArguments(key: key, changePage: changePage),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToDiscoverScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.discoverScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToProfileScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.profileScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToStreamerScreen({
    Key? key,
    required StreamerViewModel viewModel,
    bool shouldOpenLiveOnStart = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(
          key: key,
          viewModel: viewModel,
          shouldOpenLiveOnStart: shouldOpenLiveOnStart),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToChannelsScreen({
    required String game,
    required String gameId,
    Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.channelsScreen,
      arguments: ChannelsScreenArguments(game: game, gameId: gameId, key: key),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateEventStepOneScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.createEventStepOneScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToCreateEventStepTwoScreen({
    Key? key,
    required CreateEventStepTwoViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.createEventStepTwoScreen,
      arguments:
          CreateEventStepTwoScreenArguments(key: key, viewModel: viewModel),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEventStepOneEditScreen({
    Key? key,
    required EventStepOneEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.eventStepOneEditScreen,
      arguments:
          EventStepOneEditScreenArguments(key: key, viewModel: viewModel),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToEventStepTwoEditScreen({
    Key? key,
    required EventStepTwoEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.eventStepTwoEditScreen,
      arguments:
          EventStepTwoEditScreenArguments(key: key, viewModel: viewModel),
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToFavoritesScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.favoritesScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }

  Future<dynamic> navigateToOwnEventsScreen({
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo(
      Routes.ownEventsScreen,
      id: routerId,
      preventDuplicates: preventDuplicates,
      parameters: parameters,
      transition: transition,
    );
  }
}
