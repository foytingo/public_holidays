import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    // YOUR GOOGLE MAPS API KEY HERE
    GMSServices.provideAPIKey("YOUR-KEY-HERE")
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
