import 'package:app/app/app.locator.dart';
import 'package:app/app/app.router.dart';
import 'package:app/core/Ads/AdManager.dart';
import 'package:app/features/streamer/streamer_viewmodel.dart';
import 'package:app/network/models/user.dart';
import 'package:app/network/services/streamer_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

typedef Users = List<User>?;

class AgendaViewModel extends FutureViewModel<Users> {
  final _navigation = locator<NavigationService>();
  final _streamerService = locator<StreamerService>();

  late BannerAd _inlineBannerAd;
  bool _isInlineBannerAdLoaded = false;

  int get AdIndex => 1;
  bool get isAdLoaded => _isInlineBannerAdLoaded;
  BannerAd get bannerAd => _inlineBannerAd;

  @override
  Future<Users> futureToRun() async {
    return await _streamerService.getFollowingStreamers();
  }

  Future<void> startCreateEvent() async {
    return await _navigation.navigateTo(Routes.createEventDateTimeScreen);
  }

  Future<void> openStreamerWebview(String username) async {
    var url = 'https://twitch.tv/$username';
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        universalLinksOnly: true,
      );
    } else {
      throw 'Could not launch $url';
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
