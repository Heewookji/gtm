import 'package:gtm_platform_interface/gtm_platform_interface.dart';

class Gtm {
  static Gtm? _instance;
  static Gtm get instance => _instance ??= Gtm._();

  Gtm._();

  /// Set CustomTagTypes.
  void setCustomTagTypes(List<CustomTagType> tagTypes) {
    GtmPlatform.instance.setCustomTagTypes(tagTypes);
  }

  /// Push an event.
  ///
  /// [eventName] The name of the event you wish to push.
  /// [parameters] You can attach additional data to any event by passing a
  /// [Map] object with property: value pairs.
  Future<bool> push(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) {
    parameters?.removeWhere((key, value) {
      assert(
        value is String ||
            value is num ||
            value is bool ||
            value is List ||
            value is Map ||
            value == null,
        "'String', 'num', 'bool', 'List', 'Map' must be set as the value of the parameter: $key",
      );
      return value == null;
    });
    return GtmPlatform.instance.push(eventName, parameters: parameters);
  }

  /// Hide default gtm log.
  ///
  /// Unlike ios, Android doesn't already output event logs.
  void hideInfoLog() {
    return GtmPlatform.instance.hideInfoLog();
  }
}
