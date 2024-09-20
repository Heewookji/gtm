import 'dart:js_interop';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

@JS('dataLayer.push')
external void _push(JSAny? data);

class GtmWeb extends GtmPlatform {
  GtmWeb();

  static void registerWith(Registrar registarar) {
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
}
