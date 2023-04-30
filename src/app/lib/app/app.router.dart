// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i18;

import 'package:app/features/channels/channels_screen.dart' as _i10;
import 'package:app/features/discover/discover_screen.dart' as _i7;
import 'package:app/features/event/create/event_step_one/create_event_step_one_screen.dart'
    as _i11;
import 'package:app/features/event/create/event_step_two/create_event_step_two_screen.dart'
    as _i12;
import 'package:app/features/event/create/event_step_two/create_event_step_two_viewmodel.dart'
    as _i21;
import 'package:app/features/event/edit/step_one/event_step_one_edit_screen.dart'
    as _i13;
import 'package:app/features/event/edit/step_one/event_step_one_edit_viewmodel.dart'
    as _i22;
import 'package:app/features/event/edit/step_two/event_step_two_edit_screen.dart'
    as _i14;
import 'package:app/features/event/edit/step_two/event_step_two_edit_viewmodel.dart'
    as _i23;
import 'package:app/features/favorites/favorites_screen.dart' as _i15;
import 'package:app/features/home/home_screen.dart' as _i4;
import 'package:app/features/lives/lives_screen.dart' as _i6;
import 'package:app/features/login/login_screen.dart' as _i3;
import 'package:app/features/own_events/own_events_screen.dart' as _i16;
import 'package:app/features/profile/profile_screen.dart' as _i8;
import 'package:app/features/startup/startup_screen.dart' as _i2;
import 'package:app/features/streamer/streamer_screen.dart' as _i9;
import 'package:app/features/streamer/streamer_viewmodel.dart' as _i20;
import 'package:app/features/webview/webview_screen.dart' as _i5;
import 'package:flutter/foundation.dart' as _i19;
import 'package:flutter/material.dart' as _i17;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i24;

class Routes {
  static const startupScreen = '/';

  static const loginScreen = '/login-screen';

  static const homeScreen = '/home-screen';

  static const webViewScreen = '/web-view-screen';

  static const livesScreen = '/lives-screen';

  static const discoverScreen = '/discover-screen';

  static const profileScreen = '/profile-screen';

  static const streamerScreen = '/streamer-screen';

  static const channelsScreen = '/channels-screen';

  static const createEventStepOneScreen = '/create-event-step-one-screen';

  static const createEventStepTwoScreen = '/create-event-step-two-screen';

  static const eventStepOneEditScreen = '/event-step-one-edit-screen';

  static const eventStepTwoEditScreen = '/event-step-two-edit-screen';

  static const favoritesScreen = '/favorites-screen';

  static const ownEventsScreen = '/own-events-screen';

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

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.startupScreen,
      page: _i2.StartupScreen,
    ),
    _i1.RouteDef(
      Routes.loginScreen,
      page: _i3.LoginScreen,
    ),
    _i1.RouteDef(
      Routes.homeScreen,
      page: _i4.HomeScreen,
    ),
    _i1.RouteDef(
      Routes.webViewScreen,
      page: _i5.WebViewScreen,
    ),
    _i1.RouteDef(
      Routes.livesScreen,
      page: _i6.LivesScreen,
    ),
    _i1.RouteDef(
      Routes.discoverScreen,
      page: _i7.DiscoverScreen,
    ),
    _i1.RouteDef(
      Routes.profileScreen,
      page: _i8.ProfileScreen,
    ),
    _i1.RouteDef(
      Routes.streamerScreen,
      page: _i9.StreamerScreen,
    ),
    _i1.RouteDef(
      Routes.channelsScreen,
      page: _i10.ChannelsScreen,
    ),
    _i1.RouteDef(
      Routes.createEventStepOneScreen,
      page: _i11.CreateEventStepOneScreen,
    ),
    _i1.RouteDef(
      Routes.createEventStepTwoScreen,
      page: _i12.CreateEventStepTwoScreen,
    ),
    _i1.RouteDef(
      Routes.eventStepOneEditScreen,
      page: _i13.EventStepOneEditScreen,
    ),
    _i1.RouteDef(
      Routes.eventStepTwoEditScreen,
      page: _i14.EventStepTwoEditScreen,
    ),
    _i1.RouteDef(
      Routes.favoritesScreen,
      page: _i15.FavoritesScreen,
    ),
    _i1.RouteDef(
      Routes.ownEventsScreen,
      page: _i16.OwnEventsScreen,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.StartupScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.StartupScreen(),
        settings: data,
      );
    },
    _i3.LoginScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.LoginScreen(),
        settings: data,
      );
    },
    _i4.HomeScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.HomeScreen(),
        settings: data,
      );
    },
    _i5.WebViewScreen: (data) {
      final args = data.getArgs<WebViewScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.WebViewScreen(args.url, args.shouldNavigate),
        settings: data,
      );
    },
    _i6.LivesScreen: (data) {
      final args = data.getArgs<LivesScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i6.LivesScreen(key: args.key, changePage: args.changePage),
        settings: data,
      );
    },
    _i7.DiscoverScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.DiscoverScreen(),
        settings: data,
      );
    },
    _i8.ProfileScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.ProfileScreen(),
        settings: data,
      );
    },
    _i9.StreamerScreen: (data) {
      final args = data.getArgs<StreamerScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.StreamerScreen(
            key: args.key,
            viewModel: args.viewModel,
            shouldOpenLiveOnStart: args.shouldOpenLiveOnStart),
        settings: data,
      );
    },
    _i10.ChannelsScreen: (data) {
      final args = data.getArgs<ChannelsScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i10.ChannelsScreen(args.game, args.gameId, key: args.key),
        settings: data,
      );
    },
    _i11.CreateEventStepOneScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.CreateEventStepOneScreen(),
        settings: data,
      );
    },
    _i12.CreateEventStepTwoScreen: (data) {
      final args =
          data.getArgs<CreateEventStepTwoScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.CreateEventStepTwoScreen(
            key: args.key, viewModel: args.viewModel),
        settings: data,
      );
    },
    _i13.EventStepOneEditScreen: (data) {
      final args = data.getArgs<EventStepOneEditScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.EventStepOneEditScreen(
            key: args.key, viewModel: args.viewModel),
        settings: data,
      );
    },
    _i14.EventStepTwoEditScreen: (data) {
      final args = data.getArgs<EventStepTwoEditScreenArguments>(nullOk: false);
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.EventStepTwoEditScreen(
            key: args.key, viewModel: args.viewModel),
        settings: data,
      );
    },
    _i15.FavoritesScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.FavoritesScreen(),
        settings: data,
      );
    },
    _i16.OwnEventsScreen: (data) {
      return _i17.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.OwnEventsScreen(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;
  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class WebViewScreenArguments {
  const WebViewScreenArguments({
    required this.url,
    required this.shouldNavigate,
  });

  final String url;

  final _i18.Future<bool> Function(String) shouldNavigate;

  @override
  String toString() {
    return '{"url": "$url", "shouldNavigate": "$shouldNavigate"}';
  }

  @override
  bool operator ==(covariant WebViewScreenArguments other) {
    if (identical(this, other)) return true;
    return other.url == url && other.shouldNavigate == shouldNavigate;
  }

  @override
  int get hashCode {
    return url.hashCode ^ shouldNavigate.hashCode;
  }
}

class LivesScreenArguments {
  const LivesScreenArguments({
    this.key,
    required this.changePage,
  });

  final _i19.Key? key;

  final void Function(_i4.TabItem) changePage;

  @override
  String toString() {
    return '{"key": "$key", "changePage": "$changePage"}';
  }

  @override
  bool operator ==(covariant LivesScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.changePage == changePage;
  }

  @override
  int get hashCode {
    return key.hashCode ^ changePage.hashCode;
  }
}

class StreamerScreenArguments {
  const StreamerScreenArguments({
    this.key,
    required this.viewModel,
    this.shouldOpenLiveOnStart = false,
  });

  final _i19.Key? key;

  final _i20.StreamerViewModel viewModel;

  final bool shouldOpenLiveOnStart;

  @override
  String toString() {
    return '{"key": "$key", "viewModel": "$viewModel", "shouldOpenLiveOnStart": "$shouldOpenLiveOnStart"}';
  }

  @override
  bool operator ==(covariant StreamerScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.viewModel == viewModel &&
        other.shouldOpenLiveOnStart == shouldOpenLiveOnStart;
  }

  @override
  int get hashCode {
    return key.hashCode ^ viewModel.hashCode ^ shouldOpenLiveOnStart.hashCode;
  }
}

class ChannelsScreenArguments {
  const ChannelsScreenArguments({
    required this.game,
    required this.gameId,
    this.key,
  });

  final String game;

  final String gameId;

  final _i19.Key? key;

  @override
  String toString() {
    return '{"game": "$game", "gameId": "$gameId", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ChannelsScreenArguments other) {
    if (identical(this, other)) return true;
    return other.game == game && other.gameId == gameId && other.key == key;
  }

  @override
  int get hashCode {
    return game.hashCode ^ gameId.hashCode ^ key.hashCode;
  }
}

class CreateEventStepTwoScreenArguments {
  const CreateEventStepTwoScreenArguments({
    this.key,
    required this.viewModel,
  });

  final _i19.Key? key;

  final _i21.CreateEventStepTwoViewModel viewModel;

  @override
  String toString() {
    return '{"key": "$key", "viewModel": "$viewModel"}';
  }

  @override
  bool operator ==(covariant CreateEventStepTwoScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.viewModel == viewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ viewModel.hashCode;
  }
}

class EventStepOneEditScreenArguments {
  const EventStepOneEditScreenArguments({
    this.key,
    required this.viewModel,
  });

  final _i19.Key? key;

  final _i22.EventStepOneEditViewModel viewModel;

  @override
  String toString() {
    return '{"key": "$key", "viewModel": "$viewModel"}';
  }

  @override
  bool operator ==(covariant EventStepOneEditScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.viewModel == viewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ viewModel.hashCode;
  }
}

class EventStepTwoEditScreenArguments {
  const EventStepTwoEditScreenArguments({
    this.key,
    required this.viewModel,
  });

  final _i19.Key? key;

  final _i23.EventStepTwoEditViewModel viewModel;

  @override
  String toString() {
    return '{"key": "$key", "viewModel": "$viewModel"}';
  }

  @override
  bool operator ==(covariant EventStepTwoEditScreenArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.viewModel == viewModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ viewModel.hashCode;
  }
}

extension NavigatorStateExtension on _i24.NavigationService {
  Future<dynamic> navigateToStartupScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHomeScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWebViewScreen({
    required String url,
    required _i18.Future<bool> Function(String) shouldNavigate,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.webViewScreen,
        arguments:
            WebViewScreenArguments(url: url, shouldNavigate: shouldNavigate),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLivesScreen({
    _i19.Key? key,
    required void Function(_i4.TabItem) changePage,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.livesScreen,
        arguments: LivesScreenArguments(key: key, changePage: changePage),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDiscoverScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.discoverScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStreamerScreen({
    _i19.Key? key,
    required _i20.StreamerViewModel viewModel,
    bool shouldOpenLiveOnStart = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.streamerScreen,
        arguments: StreamerScreenArguments(
            key: key,
            viewModel: viewModel,
            shouldOpenLiveOnStart: shouldOpenLiveOnStart),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChannelsScreen({
    required String game,
    required String gameId,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.channelsScreen,
        arguments:
            ChannelsScreenArguments(game: game, gameId: gameId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateEventStepOneScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createEventStepOneScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateEventStepTwoScreen({
    _i19.Key? key,
    required _i21.CreateEventStepTwoViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createEventStepTwoScreen,
        arguments:
            CreateEventStepTwoScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventStepOneEditScreen({
    _i19.Key? key,
    required _i22.EventStepOneEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventStepOneEditScreen,
        arguments:
            EventStepOneEditScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventStepTwoEditScreen({
    _i19.Key? key,
    required _i23.EventStepTwoEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventStepTwoEditScreen,
        arguments:
            EventStepTwoEditScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFavoritesScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.favoritesScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOwnEventsScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ownEventsScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWebViewScreen({
    required String url,
    required _i18.Future<bool> Function(String) shouldNavigate,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.webViewScreen,
        arguments:
            WebViewScreenArguments(url: url, shouldNavigate: shouldNavigate),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLivesScreen({
    _i19.Key? key,
    required void Function(_i4.TabItem) changePage,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.livesScreen,
        arguments: LivesScreenArguments(key: key, changePage: changePage),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDiscoverScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.discoverScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStreamerScreen({
    _i19.Key? key,
    required _i20.StreamerViewModel viewModel,
    bool shouldOpenLiveOnStart = false,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.streamerScreen,
        arguments: StreamerScreenArguments(
            key: key,
            viewModel: viewModel,
            shouldOpenLiveOnStart: shouldOpenLiveOnStart),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChannelsScreen({
    required String game,
    required String gameId,
    _i19.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.channelsScreen,
        arguments:
            ChannelsScreenArguments(game: game, gameId: gameId, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateEventStepOneScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createEventStepOneScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateEventStepTwoScreen({
    _i19.Key? key,
    required _i21.CreateEventStepTwoViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createEventStepTwoScreen,
        arguments:
            CreateEventStepTwoScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventStepOneEditScreen({
    _i19.Key? key,
    required _i22.EventStepOneEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventStepOneEditScreen,
        arguments:
            EventStepOneEditScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventStepTwoEditScreen({
    _i19.Key? key,
    required _i23.EventStepTwoEditViewModel viewModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventStepTwoEditScreen,
        arguments:
            EventStepTwoEditScreenArguments(key: key, viewModel: viewModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFavoritesScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.favoritesScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOwnEventsScreen([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ownEventsScreen,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
