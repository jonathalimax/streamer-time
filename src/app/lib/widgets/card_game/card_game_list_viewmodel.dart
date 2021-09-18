import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/services/twitch_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchGameList = List<TwitchGame>;

@singleton
class CardGameListViewModel extends FutureViewModel<TwitchGameList> {
  final _navigation = locator<NavigationService>();
  final _twitchService = locator<TwitchService>();

  Future<TwitchGameList> _getTopGames() async {
    final games = await _twitchService.client.getTopGames();
    return games.data?.toList() ?? [];
  }

  @override
  Future<TwitchGameList> futureToRun() {
    return _getTopGames();
  }

  showChannelsBy(String game, String gameId) {
    _navigation.navigateTo(
      Routes.channelsScreen,
      arguments: ChannelsScreenArguments(
        game: game,
        gameId: gameId,
      ),
    );
  }
}
