import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'gtm_platform_interface_method_channel.dart';

abstract class GtmPlatformInterfacePlatform extends PlatformInterface {
  /// Constructs a GtmPlatformInterfacePlatform.
  GtmPlatformInterfacePlatform() : super(token: _token);

  static final Object _token = Object();

  static GtmPlatformInterfacePlatform _instance = MethodChannelGtmPlatformInterface();

  /// The default instance of [GtmPlatformInterfacePlatform] to use.
  ///
  /// Defaults to [MethodChannelGtmPlatformInterface].
  static GtmPlatformInterfacePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtmPlatformInterfacePlatform] when
  /// they register themselves.
  static set instance(GtmPlatformInterfacePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
