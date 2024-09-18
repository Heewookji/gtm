import 'dart:js_interop';

import 'package:gtm_platform_interface/gtm_platform_interface.dart';

class GtmWeb extends GtmPlatform {
  GtmWeb();

  static void registerWith() {
    GtmPlatform.instance = GtmWeb();
  }

  @override
  void hideInfoLog() {}

  @override
  Future<bool> push(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final Map<String, dynamic> eventData = {'event': eventName};
      if (parameters != null) {
        eventData.addAll(parameters);
      }
      _push(eventData.jsify());
      return true;
    } catch (e) {
      return false;
    }
  }

  @JS('dataLayer.push')
  external void _push(data);
}
