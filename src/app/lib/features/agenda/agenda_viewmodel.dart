import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/ads/ad_manager.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/api/firestore_api.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

typedef Users = List<User>?;

class AgendaViewModel extends BaseViewModel {
  final _navigation = locator<NavigationService>();
  final _firestoreApi = locator<FirestoreApi>();

  Users _users;

  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;

  int get AdIndex => 1;
  bool get isAdLoaded => _isInlineBannerAdLoaded;
  BannerAd get bannerAd => _inlineBannerAd;

  Users get users => _users;

  AgendaViewModel() {
    setBusy(true);
    _firestoreApi.followingStreamers.listen(_onUsersUpdated);
  }

  void _onUsersUpdated(Users users) {
    this._users = users;
    setBusy(false);
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventDateTimeScreen);
  }

  Future<void> openStreamerWebview(
      BuildContext context, String username) async {
    var url = 'https://twitch.tv/$username';
    if (await canLaunch(url)) {
      await launch(url);
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
          _isInlineBannerAdLoaded = true;
          notifyListeners();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    await _inlineBannerAd.load();
  }
}
