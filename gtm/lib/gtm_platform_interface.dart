import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gtm_method_channel.dart';

abstract class GtmPlatform extends PlatformInterface {
  /// Constructs a GtmPlatform.
  GtmPlatform() : super(token: _token);

  static final Object _token = Object();

  static GtmPlatform _instance = MethodChannelGtm();

  /// The default instance of [GtmPlatform] to use.
  ///
  /// Defaults to [MethodChannelGtm].
  static GtmPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtmPlatform] when
  /// they register themselves.
  static set instance(GtmPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
