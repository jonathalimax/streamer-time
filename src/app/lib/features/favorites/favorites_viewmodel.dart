import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  List<User> get users => _streamerService.streamers ?? [];

  Future<void> openStreamerDetails(
    String streamerId,
    String username,
  ) async {
    final viewModel = StreamerViewModel(
      streamerId: streamerId,
      username: username,
    );
    _navigationService
        .navigateTo(
          Routes.streamerScreen,
          arguments: StreamerScreenArguments(
            viewModel: viewModel,
          ),
        )
        ?.whenComplete(() => notifyListeners());
  }
}
