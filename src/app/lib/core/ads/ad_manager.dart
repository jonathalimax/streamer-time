import 'dart:io';

class AdManager {
  static String get bannerHomeUnitId {
    // TODO: Before release change home banner id
    if (Platform.isAndroid) {
      // return "ca-app-pub-7838717442900192/7118681427";
      return "ca-app-pub-3940256099942544/6300978111"; //Demo
    } else if (Platform.isIOS) {
      // return "ca-app-pub-7838717442900192/1850058788";
      return "ca-app-pub-3940256099942544/6300978111"; //Demo
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
