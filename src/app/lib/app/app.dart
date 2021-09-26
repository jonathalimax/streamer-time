import 'package:app/features/event/event_date/create_event_date_screen.dart';
import 'package:app/features/event/event_time/create_event_time_screen.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/features/agenda/agenda_screen.dart';
import 'package:app/features/agenda/agenda_viewmodel.dart';
import 'package:app/features/authentication/app_authentication.dart';
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
    MaterialRoute(page: StartupScreen, initial: true),
    MaterialRoute(page: LoginScreen),
    MaterialRoute(page: HomeScreen),
    MaterialRoute(page: WebViewScreen),
    MaterialRoute(page: AgendaScreen),
    MaterialRoute(page: DiscoverScreen),
    MaterialRoute(page: ProfileScreen),
    MaterialRoute(page: StreamerScreen),
    MaterialRoute(page: ChannelsScreen),
    MaterialRoute(page: CreateEventDateScreen),
    MaterialRoute(page: CreateEventTimeScreen),
  ],
  dependencies: [
    LazySingleton(classType: TwitchService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppAuthentication),
    LazySingleton(classType: AgendaViewModel),
    LazySingleton(classType: DiscoverViewmodel),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: CardGameListViewModel),
    LazySingleton(classType: CardStreamListViewModel),
    LazySingleton(classType: WebviewViewModel),
    LazySingleton(classType: FirestoreApi),
    LazySingleton(classType: UserService),
    LazySingleton(classType: EventService),
    LazySingleton(classType: StreamerService),
  ],
)
class AppSetup {}
