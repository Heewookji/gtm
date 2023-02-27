import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gtm_platform_interface.dart';

/// An implementation of [GtmPlatform] that uses method channels.
class MethodChannelGtm extends GtmPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gtm');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
