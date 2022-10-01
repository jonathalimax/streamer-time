import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class AdManager {
  static String get bannerHomeUnitId {
    if (kReleaseMode)
      return FirebaseRemoteConfig.instance.getString('homeBannerUnitId');

    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    return '';
  }

  static String get streamerBannerUnitId {
    if (kReleaseMode)
      return FirebaseRemoteConfig.instance.getString('streamerBannerUnitId');

    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/2934735716';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/6300978111';
    return '';
  }

  static String get interstitialAdUnitId {
    if (kReleaseMode)
      return FirebaseRemoteConfig.instance.getString('livestreamInterstitial');

    if (Platform.isIOS) return 'ca-app-pub-3940256099942544/5135589807';
    if (Platform.isAndroid) return 'ca-app-pub-3940256099942544/8691691433';
    return '';
  }
}
