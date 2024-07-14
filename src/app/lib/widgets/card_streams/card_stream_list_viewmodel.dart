import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchStreamInfoList = List<TwitchStreamInfo>?;

class CardStreamListViewModel extends FutureViewModel<TwitchStreamInfoList> {
  final _navigation = locator<NavigationService>();
  final _twitchService = locator<TwitchService>();
  final _authentication = locator<AppAuthentication>();

  @override
  Future<TwitchStreamInfoList> futureToRun() => _getStreams();

  Future<TwitchStreamInfoList> _getStreams() async {
    try {
      final userId =
          await _twitchService.client.twitchHttpClient.twitchToken.userId;
      if (userId == null) return null;

      final streams = await _twitchService.client.getFollowedStreams(
        userId: userId,
      );

      return streams.data?.toList();
    } on TwitchNotConnectedException {
      await _authentication.logout();
      return [];
    }
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
