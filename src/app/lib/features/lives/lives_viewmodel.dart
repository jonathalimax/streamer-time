import 'dart:async';

import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

typedef Users = List<User>?;

class LivesViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  int _adIndex = 1;
  bool _isBannerAdLoaded = false;

  late Users streamers = _streamerService.streamers;
  late BannerAd _inlineBannerAd;

  BannerAd get bannerAd => _inlineBannerAd;

  List<Object> get items {
    if (streamers == null) return [];
    var filteredUsers = streamers!;

    filteredUsers.removeWhere((user) => user.events.isEmpty);

    if (filteredUsers.isNotEmpty && _isBannerAdLoaded) {
      List<Object> usersWithAds = [];
      usersWithAds.insertAll(0, streamers!);
      usersWithAds.insert(_adIndex, _inlineBannerAd);
      return usersWithAds;
    }

    return streamers!;
  }

  LivesViewModel() {
    buildInlineBannerAd();
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

  Future<void> buildInlineBannerAd() async {
    _inlineBannerAd = BannerAd(
      size: AdSize.largeBanner,
      adUnitId: AdManager.bannerHomeUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (!_isBannerAdLoaded) {
            _isBannerAdLoaded = true;
            notifyListeners();
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
