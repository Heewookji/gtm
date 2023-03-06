import 'package:plugin_platform_interface/plugin_platform_interface.dart';

typedef CustomTagHandler = Future<void> Function(
  String event,
  dynamic arguments,
);

const String customTagMethod = 'CustomTag';
const String eventNamePropertyName = 'eventName';

abstract class GtmPlatform extends PlatformInterface {
  /// Constructs a GtmPlatform.
  GtmPlatform() : super(token: _token);

  static final Object _token = Object();

  static GtmPlatform? _instance;

  /// The default instance of [GtmPlatform] to use.
  static GtmPlatform get instance => _instance ?? GtmDefault();

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GtmPlatform] when
  /// they register themselves.
  static set instance(GtmPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  void setCustomTagHandler(CustomTagHandler handler) {
    throw UnimplementedError('setCustomTagHandler() has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

class GtmDefault extends GtmPlatform {}
