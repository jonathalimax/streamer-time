import 'package:app/app/app.locator.dart';
import 'package:app/services/twitch_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

@singleton
class DiscoverViewmodel extends FutureViewModel<List<TwitchGame>> {
  final _twitchService = locator<TwitchService>();

  Future<List<TwitchGame>> _getTopGames() async {
    await _twitchService.prepare();
    final games = await _twitchService.client.getTopGames();
    return games.data?.toList() ?? [];
  }

  @override
  Future<List<TwitchGame>> futureToRun() {
    return _getTopGames();
  }
}
