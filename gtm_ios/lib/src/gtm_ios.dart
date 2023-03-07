import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

const MethodChannel _channel = MethodChannel('heewook.kr/gtm_ios');

class GtmIOS extends GtmPlatform {
  /// Registers this class as the default instance of [GtmPlatform].
  static void registerWith() {
    GtmPlatform.instance = GtmIOS();
  }

  @override
  void setCustomTags(List<CustomTag> tags) {
    _channel.setMethodCallHandler(
      (call) async {
        if (call.method != GtmPlatform.customTag) return;
        final arguments = json.decode(call.arguments);
        final tag = tags.firstWhere(
          (tag) => tag.tagType == arguments[GtmPlatform.tagType],
        );
        await tag.handler(arguments[GtmPlatform.eventName], arguments);
      },
    );
  }

  @override
  Future<bool> push(
    String eventName, {
    required Map<String, dynamic> parameters,
  }) async {
    final result = await _channel.invokeMethod<bool>(
        'push',
        jsonEncode({
          GtmPlatform.eventName: eventName,
          GtmPlatform.eventParameters: parameters,
        }));
    return result ?? false;
  }
}
