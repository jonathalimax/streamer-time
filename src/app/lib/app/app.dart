import 'package:app/features/agenda/agenda_screen.dart';
import 'package:app/features/authentication/app_authentication.dart';
import 'package:app/features/discover/discover_screen.dart';
import 'package:app/features/home/home_screen.dart';
import 'package:app/features/home/home_viewmodel.dart';
import 'package:app/features/login/login_screen.dart';
import 'package:app/features/startup/startup_screen.dart';
import 'package:app/features/webview/webview_screen.dart';
import 'package:app/services/twitch_service.dart';
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
  ],
  dependencies: [
    LazySingleton(classType: TwitchService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppAuthentication),
    LazySingleton(classType: HomeViewModel),
    LazySingleton(classType: CardGameListViewModel),
    LazySingleton(classType: CardStreamListViewModel),
  ],
)
class AppSetup {}
