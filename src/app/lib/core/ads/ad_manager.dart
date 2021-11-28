import 'dart:io';

class AdManager {
  static String get bannerHomeUnitId {
    // TODO: Before release remove this return
    return 'ca-app-pub-3940256099942544/6300978111';

    if (Platform.isAndroid) {
      return 'ca-app-pub-7838717442900192/7118681427';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7838717442900192/1850058788';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get streamerBannerUnitId {
    // TODO: Before release remove this return
    return 'ca-app-pub-3940256099942544/2934735716';

    if (Platform.isAndroid) {
      return 'ca-app-pub-7838717442900192/3008328838';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-7838717442900192/6408517798';
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
