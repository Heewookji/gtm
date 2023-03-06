import Flutter
import UIKit
import FirebaseAnalytics
import Foundation
import GoogleTagManager

public class SwiftGtmIosPlugin: NSObject, FlutterPlugin {

  public static var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "heewook.kr/gtm_ios", binaryMessenger: registrar.messenger())
    let instance = SwiftGtmIosPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel!)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
//     result("iOS " + UIDevice.current.systemVersion)
      Analytics.logEvent("test", parameters: [:])
  }
}

@objc(CustomTag)
final class CustomTag: NSObject, TAGCustomFunction {
    func execute(withParameters parameters: [AnyHashable : Any]!) -> NSObject! {
        SwiftGtmIosPlugin.channel!.invokeMethod("CustomTag", arguments: parameters)
        return nil
    }
}
