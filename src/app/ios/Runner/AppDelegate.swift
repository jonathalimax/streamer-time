import UIKit
import Flutter
import GoogleMobileAds

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

	GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["8965c112c3a098ac06c29461572bd4a1"]

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
