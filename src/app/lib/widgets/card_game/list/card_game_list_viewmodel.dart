import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:twitch_api/twitch_api.dart';

typedef TwitchGameList = List<TwitchGame>;

class CardGameListViewModel extends FutureViewModel<TwitchGameList> {
  final _navigation = locator<NavigationService>();
  final _authentication = locator<AppAuthentication>();
  final _twitchService = locator<TwitchService>();
  final _remoteConfig = FirebaseRemoteConfig.instance;

  bool get isGraphicsboolEnabled =>
      _remoteConfig.getBool("discoveryGraphicsEnabled");

  Future<TwitchGameList> _getTopGames() async {
    try {
      final games = await _twitchService.client.getTopGames();
      return games.data?.toList() ?? [];
    } on TwitchNotConnectedException {
      await _authentication.logout();
      return [];
    }
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
