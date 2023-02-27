import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gtm_ios_method_channel.dart';

abstract class GtmIosPlatform extends PlatformInterface {
  /// Constructs a GtmIosPlatform.
  GtmIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static GtmIosPlatform _instance = MethodChannelGtmIos();

  /// The default instance of [GtmIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelGtmIos].
  static GtmIosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtmIosPlatform] when
  /// they register themselves.
  static set instance(GtmIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
