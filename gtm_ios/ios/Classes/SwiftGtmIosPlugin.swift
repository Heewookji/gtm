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
    
  public func decodeArguments(_ callArguments: Any?) throws -> [String:Any]? {
        if let arguments = callArguments, let data = (arguments as! String).data(using: .utf8) {
            let parameters = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            return parameters;
        }
        return nil;
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    do {
      switch call.method {
        case "push":
          if let args = try decodeArguments(call.arguments) {
            let eventName = args["eventName"] as! String
            let eventParameters = args["eventParameters"] as! [String: Any]?
            Analytics.logEvent(eventName, parameters: eventParameters)
            result(true)
          } else {
            result(false)
          }
        case "hideInfoLog":
          hideInfoLog()
        default:
          result(FlutterMethodNotImplemented)
      }
    } catch {
      result(FlutterError.init(
        code: "EXCEPTION_IN_HANDLE",
        message: "Exception happened in handle.",
        details: nil
      ))
    }
  }

  private func hideInfoLog() {
    let tagClass: AnyClass? = NSClassFromString("TAGLogger")
    let originalSelector = NSSelectorFromString("info:")
    let detourSelector = #selector(SwiftGtmIosPlugin.detour_info(message:))
    guard let originalMethod = class_getClassMethod(tagClass, originalSelector),
        let detourMethod = class_getClassMethod(SwiftGtmIosPlugin.self, detourSelector) else { return }
    class_addMethod(tagClass, detourSelector,
                    method_getImplementation(detourMethod), method_getTypeEncoding(detourMethod))
    method_exchangeImplementations(originalMethod, detourMethod)
  }

  @objc
  static private func detour_info(message: String) {
      return
  }
}

@objc(CustomTag)
final class CustomTag: NSObject, TAGCustomFunction {

    func encodeArguments(_ callArguments: Any?) throws -> String? {
        if(callArguments != nil) {
            let jsonData = try JSONSerialization.data(withJSONObject: callArguments!, options: [])
            if let parameters = String(data: jsonData, encoding: .utf8) {
                return parameters
            }
        }
        return nil
    }

    func execute(withParameters parameters: [AnyHashable : Any]!) -> NSObject! {
        do {
          try SwiftGtmIosPlugin.channel!.invokeMethod("CustomTag", arguments: encodeArguments(parameters))
        } catch {
          return nil
        }
        return nil
    }
}
