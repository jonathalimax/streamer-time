// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../core/ads/ad_manager.dart';
import '../core/analytics/analytics.dart';
import '../core/authentication/app_authentication.dart';
import '../core/caching/caching_manager.dart';
import '../core/notifications/push_notification_manager.dart';
import '../features/discover/discover_viewmodel.dart';
import '../features/lives/lives_viewmodel.dart';
import '../features/profile/profile_viewmodel.dart';
import '../features/webview/webview_viewmodel.dart';
import '../network/api/dio_client.dart';
import '../network/api/firebase_storage_api.dart';
import '../network/api/firestore_api.dart';
import '../network/services/event_service.dart';
import '../network/services/streamer_service.dart';
import '../network/services/twitch_service.dart';
import '../network/services/user_service.dart';
import '../stores/streamer_store.dart';
import '../widgets/card_game/list/card_game_list_viewmodel.dart';
import '../widgets/card_streams/card_stream_list_viewmodel.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => TwitchService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AppAuthentication());
  locator.registerLazySingleton(() => LivesViewModel());
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
  locator.registerLazySingleton(() => CachingManager());
  locator.registerLazySingleton(() => StreamerStore());
  locator.registerLazySingleton(() => Analytics());
  locator.registerLazySingleton(() => DioClient());
}
