import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/user.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FavoritesViewModel extends BaseViewModel {
  final _firestoreApi = locator<FirestoreApi>();
  final _navigationService = locator<NavigationService>();

  List<User>? _users;
  List<User> get users => _users ?? [];

  FavoritesViewModel() {
    setBusy(true);
    _firestoreApi.followingStreamers.listen(_onUsersUpdated);
  }

  void _onUsersUpdated(Users users) {
    this._users = users;
    setBusy(false);
  }

  Future<void> openStreamerDetails(
    String streamerId,
    String username,
  ) async {
    final viewModel = StreamerViewModel(
      streamerId: streamerId,
      username: username,
    );
    await _navigationService.navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(
        viewModel: viewModel,
      ),
    );
  }
}
