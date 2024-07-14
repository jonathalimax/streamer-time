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

	GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["02ab671d89bcc1739ed16cd50f8b4b0f"]

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
