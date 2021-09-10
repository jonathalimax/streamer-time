import 'package:app/app/app.locator.dart';
import 'package:app/services/twitch_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchStreamInfoList = List<TwitchStreamInfo>;

@singleton
class CardStreamListViewModel extends FutureViewModel<TwitchStreamInfoList> {
  final _twitchService = locator<TwitchService>();

  @override
  Future<TwitchStreamInfoList> futureToRun() {
    return _getStreams();
  }

  Future<List<TwitchStreamInfo>> _getStreams() async {
    final userId =
        await _twitchService.client.twitchHttpClient.twitchToken.userId;
    if (userId != null) {
      final streams =
          await _twitchService.client.getFollowedStreams(userId: userId);
      return streams.data?.toList() ?? [];
    }
    return [];
  }
}
