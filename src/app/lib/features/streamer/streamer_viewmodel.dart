import 'package:app/app/app.locator.dart';
import 'package:app/services/twitch_service.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

const String _agendaFuture = 'agendaFuture';
const String _streamerFuture = 'streamerFuture';

class StreamerViewModel extends MultipleFutureViewModel {
  final String streamerId;

  final _twitchService = locator<TwitchService>();

  StreamerViewModel({
    required this.streamerId,
  });

  String get fetchedAgenda => dataMap![_agendaFuture];
  TwitchUser? get fetchedStreamer => dataMap![_streamerFuture];

  bool get fetchingAgenda => busy(_agendaFuture);
  bool get fetchingStreamer => busy(_streamerFuture);

  @override
  Map<String, Future Function()> get futuresMap => {
        _agendaFuture: getStreamerAgenda,
        _streamerFuture: getStreamerById,
      };

  Future<TwitchUser?> getStreamerById() async {
    final user = await _twitchService.client.getUsers(ids: [streamerId]);
    if (user.data == null) return null;
    return user.data?.first ?? null;
  }

  Future<String> getStreamerAgenda() async {
    return 'String data';
  }
}
