import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gtm_android_platform_interface.dart';

/// An implementation of [GtmAndroidPlatform] that uses method channels.
class MethodChannelGtmAndroid extends GtmAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gtm_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
