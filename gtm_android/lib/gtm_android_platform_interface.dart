import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gtm_android_method_channel.dart';

abstract class GtmAndroidPlatform extends PlatformInterface {
  /// Constructs a GtmAndroidPlatform.
  GtmAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static GtmAndroidPlatform _instance = MethodChannelGtmAndroid();

  /// The default instance of [GtmAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelGtmAndroid].
  static GtmAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtmAndroidPlatform] when
  /// they register themselves.
  static set instance(GtmAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
