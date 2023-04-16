import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/core/analytics/analytics.dart';
import 'package:app/core/caching/caching_manager.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:app/stores/streamer_store.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class LivesViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();
  final _streamerStore = locator<StreamerStore>();
  final _cachingManager = locator<CachingManager>();
  final _analytics = locator<Analytics>();

  late final store = _streamerStore;

  BannerAd? _inlineBannerAd;
  InterstitialAd? _interstitialAd;

  BannerAd? get bannerAd => _inlineBannerAd;

  LivesViewModel() {
    buildBannerAd();
    buildInterstitialAd();
    setBusy(true);
    if (store.streamers.isEmpty) fetchStreamers();
  }

  Future<void> fetchStreamers() async {
    await _streamerService.fetchLives() ?? [];
    setBusy(false);
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventStepOneScreen);
  }

  Future<void> openStreamerWebview(
    BuildContext context,
    String username,
  ) async {
    var url = Uri(
      scheme: 'https',
      host: 'twitch.tv',
      path: '$username',
    );

    if (!await canLaunchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText.captionBold(
            'Nos desculpe, mas ocorreu um erro inesperado!',
          ),
        ),
      );
    }

    if (await _cachingManager.shouldAppearFullAd()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText.captionBold(
            'Assistindo o anúncio a seguir, você estará nos dando suporte total! 🫡',
          ),
          duration: Duration(seconds: 4),
        ),
      );
      await Future.delayed(Duration(seconds: 4));
      await showInterstitialAdWithCallback(url);
    } else {
      await launchStreamerUrl(url);
    }
  }

  Future<void> openStreamerScreen(
    String streamerId,
    String username,
  ) async {
    final viewModel = StreamerViewModel(
      streamerId: streamerId,
      username: username,
    );
    _navigation.navigateTo(
      Routes.streamerScreen,
      arguments: StreamerScreenArguments(viewModel: viewModel),
    );
  }

  Future<void> buildBannerAd() async {
    _inlineBannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdManager.bannerHomeUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdImpression: (ad) => _analytics.instance.logAdImpression(
          adPlatform: 'AdMob',
          adFormat: 'Banner',
          adUnitName: 'Home Banner',
        ),
        onAdFailedToLoad: (ad, _) {
          ad.dispose();
          _inlineBannerAd = null;
          notifyListeners();
        },
      ),
    );
    await _inlineBannerAd?.load();
  }

  Future buildInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdManager.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (_) {
          _interstitialAd?.dispose();
        },
      ),
    );
  }

  Future showInterstitialAdWithCallback(Uri callbackUrl) async {
    _interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdWillDismissFullScreenContent: (_) async {
        await launchStreamerUrl(callbackUrl);
        await buildInterstitialAd();
      },
      onAdImpression: (ad) => _analytics.instance.logAdImpression(
        adPlatform: 'AdMob',
        adFormat: 'Interstitial',
        adUnitName: 'Livestream Interstitial',
      ),
      onAdDismissedFullScreenContent: (ad) => ad.dispose(),
      onAdFailedToShowFullScreenContent: (ad, _) => ad.dispose(),
    );
    await _interstitialAd?.show();
  }

  Future launchStreamerUrl(Uri url) async {
    await _cachingManager.incrementLivesOpened();
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }
}
