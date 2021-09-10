// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../features/authentication/app_authentication.dart';
import '../features/home/home_viewmodel.dart';
import '../services/twitch_service.dart';
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
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => CardGameListViewModel());
  locator.registerLazySingleton(() => CardStreamListViewModel());
}
