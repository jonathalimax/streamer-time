import 'package:app/app/app.locator.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/core/notifications/push_notification_manager.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/event_service.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

const String _agendaFuture = 'agendaFuture';
const String _streamerFuture = 'streamerFuture';

class StreamerViewModel extends MultipleFutureViewModel {
  final String streamerId;
  final String username;

  late BannerAd _bannerAd;
  BannerAd get bannerAd => _bannerAd;

  final _twitchService = locator<TwitchService>();
  final _eventsService = locator<EventService>();
  final _streamerService = locator<StreamerService>();
  final _pushNotificationManager = locator<PushNotificationManager>();

  StreamerViewModel({
    required this.streamerId,
    required this.username,
  }) {
    _buildBannerAd();
  }

  String get fetchedAgenda => dataMap![_agendaFuture];
  User? get fetchedStreamer => dataMap![_streamerFuture];

  bool get fetchingAgenda => busy(_agendaFuture);
  bool get fetchingStreamer => busy(_streamerFuture);

  @override
  Map<String, Future Function()> get futuresMap => {
        _agendaFuture: getStreamerAgenda,
        _streamerFuture: getStreamerById,
      };

  Future<User?> getStreamerById() async {
    final twitchUser = await _twitchService.client.getUsers(ids: [streamerId]);
    if (twitchUser.data?.first == null) return null;
    final user = User.fromTwitch(twitchUser: twitchUser.data!.first);
    user.following = await _streamerService.isFollowingStreamer(streamerId);
    user.events = await _eventsService.getStreamerEvents(streamerId);
    return user;
  }

  Future<String> getStreamerAgenda() async {
    return 'String data';
  }

  Future<void> followStreamer() async {
    setBusy(true);
    await _streamerService.followStreamer(streamerId);
    await _pushNotificationManager.subscribeToTopic(username);
    (dataMap![_streamerFuture] as User).following = true;
    setBusy(false);
  }

  Future<void> unfollowStreamer() async {
    setBusy(true);
    await _streamerService.unfollowStreamer(streamerId);
    await _pushNotificationManager.unsubscribeFromTopic(username);
    (dataMap![_streamerFuture] as User).following = false;
    setBusy(false);
  }

  Future<void> _buildBannerAd() async {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManager.streamerBannerUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdFailedToLoad: (ad, _) => ad.dispose(),
      ),
    );
    await _bannerAd.load();
  }
}
