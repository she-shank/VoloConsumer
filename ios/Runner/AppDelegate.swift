import UIKit
import Flutter

@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Additional configurations if necessary can be added here

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
