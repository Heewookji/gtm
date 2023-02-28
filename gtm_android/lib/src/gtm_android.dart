import 'package:flutter/services.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

const MethodChannel _channel = MethodChannel('heewook.kr/gtm_android');

class GtmAndroid extends GtmPlatform {
  /// Registers this class as the default instance of [GtmPlatform].
  static void registerWith() {
    GtmPlatform.instance = GtmAndroid();
  }

  @override
  Future<String?> getPlatformVersion() {
    return _channel.invokeMethod<String>('getPlatformVersion');
  }
}
