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
    required Map<String, dynamic> parameters,
  }) {
    return GtmPlatform.instance.push(eventName, parameters: parameters);
  }
}
