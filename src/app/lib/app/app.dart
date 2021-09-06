import 'package:app/features/home/home_view.dart';
import 'package:app/features/login/login_view.dart';
import 'package:app/widget/webview_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(page: HomeScreen, initial: false),
    MaterialRoute(page: WebViewScreen),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class AppSetup {}
