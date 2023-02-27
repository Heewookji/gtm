import 'package:flutter_test/flutter_test.dart';
import 'package:gtm_android/gtm_android.dart';
import 'package:gtm_android/gtm_android_platform_interface.dart';
import 'package:gtm_android/gtm_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGtmAndroidPlatform
    with MockPlatformInterfaceMixin
    implements GtmAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GtmAndroidPlatform initialPlatform = GtmAndroidPlatform.instance;

  test('$MethodChannelGtmAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGtmAndroid>());
  });

  test('getPlatformVersion', () async {
    GtmAndroid gtmAndroidPlugin = GtmAndroid();
    MockGtmAndroidPlatform fakePlatform = MockGtmAndroidPlatform();
    GtmAndroidPlatform.instance = fakePlatform;

    expect(await gtmAndroidPlugin.getPlatformVersion(), '42');
  });
}
