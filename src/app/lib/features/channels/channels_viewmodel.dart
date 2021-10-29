import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchStreamInfoList = List<TwitchStreamInfo>;

class ChannelsViewModel extends FutureViewModel<TwitchStreamInfoList> {
  final String _gameId;

  final _navigation = locator<NavigationService>();
  final _twitchService = locator<TwitchService>();

  ChannelsViewModel(this._gameId);

  @override
  Future<TwitchStreamInfoList> futureToRun() {
    return _getStreams();
  }

  Future<List<TwitchStreamInfo>> _getStreams() async {
    final streams = await _twitchService.client.getStreams(gameIds: [_gameId]);
    return streams.data?.toList() ?? [];
  }

  startStreamerScreen(
    String streamerId,
    String username,
  ) {
    final viewModel = StreamerViewModel(
      streamerId: streamerId,
      username: username,
    );
    _navigation.navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(viewModel: viewModel),
    );
  }
}
