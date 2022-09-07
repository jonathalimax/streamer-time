import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/stores/streamer_store.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritesViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _streamerStore = locator<StreamerStore>();

  late final store = _streamerStore;

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
