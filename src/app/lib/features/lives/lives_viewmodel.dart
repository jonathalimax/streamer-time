import 'dart:async';

import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class LivesViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _firestoreApi = locator<FirestoreApi>();

  bool _isBannerAdLoaded = false;

  late Users streamers = [];
  late BannerAd _inlineBannerAd;

  BannerAd get bannerAd => _inlineBannerAd;

  LivesViewModel() {
    buildBannerAd();
    _firestoreApi.followingStreamers.listen(_onStreamersUpdated);
  }

  void _onStreamersUpdated(Users users) {
    this.streamers = users;
    notifyListeners();
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventStepOneScreen);
  }

  Future<void> openStreamerWebview(
      BuildContext context, String username) async {
    var url = Uri(
      scheme: 'https',
      host: 'twitch.tv',
      path: '$username',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText.captionBold('Ocorreu um erro ao abrir o evento!'),
        ),
      );
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
    await _navigation.navigateTo(
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
        onAdLoaded: (_) {
          if (!_isBannerAdLoaded) {
            _isBannerAdLoaded = true;
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    await _inlineBannerAd.load();
  }
}
