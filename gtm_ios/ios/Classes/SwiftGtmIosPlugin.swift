import Flutter
import UIKit
import FirebaseAnalytics

public class SwiftGtmIosPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "heewook.kr/gtm_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftGtmIosPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     result("iOS " + UIDevice.current.systemVersion)
      Analytics.logEvent("test", parameters: [:])
  }
}
