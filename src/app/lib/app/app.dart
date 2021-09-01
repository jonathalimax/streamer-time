import 'package:app/features/login/login_view.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: LoginView, initial: true),
  ],
)
class AppSetup {}
