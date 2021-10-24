import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchStreamInfoList = List<TwitchStreamInfo>?;

class CardStreamListViewModel extends FutureViewModel<TwitchStreamInfoList> {
  final _navigation = locator<NavigationService>();
  final _twitchService = locator<TwitchService>();

  @override
  Future<TwitchStreamInfoList> futureToRun() {
    return _getStreams();
  }

  Future<TwitchStreamInfoList> _getStreams() async {
    final userId =
        await _twitchService.client.twitchHttpClient.twitchToken.userId;
    if (userId != null) {
      final streams =
          await _twitchService.client.getFollowedStreams(userId: userId);
      return streams.data?.toList();
    }
    return null;
  }

  startStreamerScreen(String streamerId) {
    final viewModel = StreamerViewModel(streamerId: streamerId);
    _navigation.navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(viewModel: viewModel),
    );
  }
}
