import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'gtm_platform_interface_platform_interface.dart';

/// An implementation of [GtmPlatformInterfacePlatform] that uses method channels.
class MethodChannelGtmPlatformInterface extends GtmPlatformInterfacePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('gtm_platform_interface');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
