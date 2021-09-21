// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../api/firestore_api.dart';
import '../features/agenda/agenda_viewmodel.dart';
import '../features/authentication/app_authentication.dart';
import '../features/discover/discover_viewmodel.dart';
import '../features/profile/profile_viewmodel.dart';
import '../features/webview/webview_viewmodel.dart';
import '../services/twitch_service.dart';
import '../services/user_service.dart';
import '../widgets/card_game/card_game_list_viewmodel.dart';
import '../widgets/card_streams/card_stream_list_viewmodel.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => TwitchService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AppAuthentication());
  locator.registerLazySingleton(() => AgendaViewModel());
  locator.registerLazySingleton(() => DiscoverViewmodel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => CardGameListViewModel());
  locator.registerLazySingleton(() => CardStreamListViewModel());
  locator.registerLazySingleton(() => WebviewViewModel());
  locator.registerLazySingleton(() => FirestoreApi());
  locator.registerLazySingleton(() => UserService());
}
