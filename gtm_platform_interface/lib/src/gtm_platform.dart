import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class CustomTag {
  final String tagType;
  final Function(
    String eventName,
    Map<String, dynamic> parameters,
  ) handler;

  CustomTag(
    this.tagType, {
    required this.handler,
  });
}

abstract class GtmPlatform extends PlatformInterface {
  static const String customTag = 'CustomTag';
  static const String eventName = 'eventName';
  static const String tagType = 'tagType';
  static const String eventParameters = 'eventParameters';

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

  void setCustomTags(List<CustomTag> tags) {
    throw UnimplementedError('setCustomTags() has not been implemented.');
  }

  Future<bool> push(
    String eventName, {
    required Map<String, dynamic> parameters,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

class GtmDefault extends GtmPlatform {}
