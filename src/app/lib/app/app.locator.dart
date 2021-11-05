// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/ads/ad_manager.dart';
import '../core/Notifications/push_notification_manager.dart';
import '../features/agenda/agenda_viewmodel.dart';
import '../features/authentication/app_authentication.dart';
import '../features/discover/discover_viewmodel.dart';
import '../features/profile/profile_viewmodel.dart';
import '../features/webview/webview_viewmodel.dart';
import '../network/api/firebase_storage_api.dart';
import '../network/api/firestore_api.dart';
import '../network/services/event_service.dart';
import '../network/services/streamer_service.dart';
import '../network/services/twitch_service.dart';
import '../network/services/user_service.dart';
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
  locator.registerLazySingleton(() => FirebaseStorageApi());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => StreamerService());
  locator.registerLazySingleton(() => PushNotificationManager());
  locator.registerLazySingleton(() => AdManager());
}
