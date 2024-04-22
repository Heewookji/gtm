import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';

const MethodChannel _channel = MethodChannel('heewook.kr/gtm_android');

class GtmAndroid extends GtmPlatform {
  /// Registers this class as the default instance of [GtmPlatform].
  static void registerWith() {
    GtmPlatform.instance = GtmAndroid();
  }

  @override
  void setCustomTagTypes(List<CustomTagType> tagTypes) {
    _channel.setMethodCallHandler(
      (call) async {
        if (call.method != GtmPlatform.customTag) return;
        final arguments = json.decode(call.arguments);
        final triggeredTagType = tagTypes.firstWhere(
          (tagType) => tagType.name == arguments[GtmPlatform.tagType],
        );
        await triggeredTagType.handler(
          arguments[GtmPlatform.eventName],
          arguments,
        );
      },
    );
  }

  @override
  Future<bool> push(
    String eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    final result = await _channel.invokeMethod<bool>(
        'push',
        jsonEncode({
          GtmPlatform.eventName: eventName,
          if (parameters != null) GtmPlatform.eventParameters: parameters,
        }));
    return result ?? false;
  }

  @override
  void hideInfoLog() {
    _channel.invokeMethod<void>(
      'hideInfoLog',
    );
  }
}
