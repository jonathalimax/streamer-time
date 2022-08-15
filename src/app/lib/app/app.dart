import 'package:app/core/ads/ad_manager.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/core/notifications/push_notification_manager.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/features/event/create/event_step_one/create_event_step_one_screen.dart';
import 'package:app/features/event/create/event_step_two/create_event_step_two_screen.dart';
import 'package:app/features/event/edit/step_one/event_step_one_edit_screen.dart';
import 'package:app/features/event/edit/step_two/event_step_two_edit_screen.dart';
import 'package:app/features/favorites/favorites_screen.dart';
import 'package:app/features/lives/lives_screen.dart';
import 'package:app/features/lives/lives_viewmodel.dart';
import 'package:app/features/own_events/own_events_screen.dart';
import 'package:app/features/splash/splash_screen.dart';
import 'package:app/network/api/firebase_storage_api.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/features/channels/channels_screen.dart';
import 'package:app/features/discover/discover_screen.dart';
import 'package:app/features/discover/discover_viewmodel.dart';
import 'package:app/features/home/home_screen.dart';
import 'package:app/features/login/login_screen.dart';
import 'package:app/features/profile/profile_screen.dart';
import 'package:app/features/profile/profile_viewmodel.dart';
import 'package:app/features/startup/startup_screen.dart';
import 'package:app/features/streamer/streamer_screen.dart';
import 'package:app/features/webview/webview_screen.dart';
import 'package:app/features/webview/webview_viewmodel.dart';
import 'package:app/network/services/event_service.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:app/network/services/user_service.dart';
import 'package:app/widgets/card_game/card_game_list_viewmodel.dart';
import 'package:app/widgets/card_streams/card_stream_list_viewmodel.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreen, initial: true),
    MaterialRoute(page: StartupScreen),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: WebViewScreen),
    MaterialRoute(page: LivesScreen),
    MaterialRoute(page: DiscoverScreen),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: StreamerScreen),
    MaterialRoute(page: ChannelsScreen),
    MaterialRoute(page: CreateEventStepOneScreen),
    MaterialRoute(page: CreateEventStepTwoScreen),
    MaterialRoute(page: EventStepOneEditScreen),
    MaterialRoute(page: EventStepTwoEditScreen),
    MaterialRoute(page: FavoritesScreen),
    MaterialRoute(page: OwnEventsScreen),
  ],
  dependencies: [
    LazySingleton(classType: TwitchService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppAuthentication),
    LazySingleton(classType: LivesViewModel),
    LazySingleton(classType: DiscoverViewmodel),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: CardGameListViewModel),
    LazySingleton(classType: CardStreamListViewModel),
    LazySingleton(classType: WebviewViewModel),
    LazySingleton(classType: FirestoreApi),
    LazySingleton(classType: FirebaseStorageApi),
    LazySingleton(classType: UserService),
    LazySingleton(classType: EventService),
    LazySingleton(classType: StreamerService),
    LazySingleton(classType: PushNotificationManager),
    LazySingleton(classType: AdManager),
    LazySingleton(classType: CachingManager),
  ],
)
class AppSetup {}
