import UIKit
import Flutter
import AdSupport

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

	  print(ASIdentifierManager.shared().advertisingIdentifier)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
