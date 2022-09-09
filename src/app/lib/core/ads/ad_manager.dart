import 'dart:io';

class AdManager {
  static String get bannerHomeUnitId {
    // TODO: Use the firebase remote config `homeBannerUnitId`
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    return '';
  }

  static String get streamerBannerUnitId {
    // TODO: Use the firebase remote config `streamerBannerUnitId`
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    return '';
  }

  static String get interstitialAdUnitId {
    // TODO: Use the firebase remote config `streamerBannerUnitId`
    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/5135589807';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/8691691433';
    return '';
  }
}
