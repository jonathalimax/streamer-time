import 'package:app/app/app.locator.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/core/analytics/analytics.dart';
import 'package:app/core/authentication/app_authentication.dart';
import 'package:app/core/notifications/push_notification_manager.dart';
import 'package:app/features/lives/lives_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/event_service.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:app/network/services/twitch_service.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:twitch_api/twitch_api.dart';

const String _agendaFuture = 'agendaFuture';
const String _streamerFuture = 'streamerFuture';

class StreamerViewModel extends MultipleFutureViewModel {
  final _analytics = locator<Analytics>();

  final String streamerId;
  final String username;

  late BannerAd _bannerAd;
  BannerAd get bannerAd => _bannerAd;

  final _authService = locator<AppAuthentication>();
  final _twitchService = locator<TwitchService>();
  final _eventsService = locator<EventService>();
  final _streamerService = locator<StreamerService>();
  final _pushNotificationManager = locator<PushNotificationManager>();
  final _livesViewModel = locator<LivesViewModel>();

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
    try {
      final twitchUser = await _twitchService.client.getUsers(
        ids: [streamerId],
      );
      if (twitchUser.data?.first == null) return null;
      final user = User.fromTwitch(twitchUser: twitchUser.data!.first);
      user.following = await _streamerService.isFollowingStreamer(streamerId);
      user.events = await _eventsService.getStreamerEvents(streamerId);
      return user;
    } on TwitchNotConnectedException {
      await _authService.logout();
      return null;
    }
  }

  Future<String> getStreamerAgenda() async {
    return 'String data';
  }

  Future onEventTap(BuildContext context, String username) async {
    _livesViewModel.openStreamerWebview(context, username);
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
        onAdImpression: (ad) => _analytics.instance.logAdImpression(
          adPlatform: 'AdMob',
          adFormat: 'Banner',
          adUnitName: 'Streamer Banner',
        ),
        onAdFailedToLoad: (ad, _) => ad.dispose(),
      ),
    );
    await _bannerAd.load();
  }
}
