import 'package:flutter/services.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

const MethodChannel _channel = MethodChannel('heewook.kr/gtm_ios');

class GtmIOS extends GtmPlatform {
  /// Registers this class as the default instance of [GtmPlatform].
  static void registerWith() {
    GtmPlatform.instance = GtmIOS();
  }

  @override
  void setCustomTagHandler(CustomTagHandler handler) {
    _channel.setMethodCallHandler(
      (call) async {
        if (call.method != customTagMethod) return;
        await handler(call.arguments[eventNamePropertyName], call.arguments);
      },
    );
  }

  @override
  Future<String?> getPlatformVersion() {
    return _channel.invokeMethod<String>('getPlatformVersion');
  }
}
