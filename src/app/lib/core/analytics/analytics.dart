import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Analytics {
  FirebaseAnalytics get instance => FirebaseAnalytics.instance;

  Future<void> configure() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    FirebaseAnalytics.instance.setDefaultEventParameters({
      'buildNumber': packageInfo.buildNumber,
      'version': packageInfo.version,
    });
  }
}
