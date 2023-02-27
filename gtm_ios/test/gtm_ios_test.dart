import 'package:flutter_test/flutter_test.dart';
import 'package:gtm_ios/gtm_ios.dart';
import 'package:gtm_ios/gtm_ios_platform_interface.dart';
import 'package:gtm_ios/gtm_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGtmIosPlatform
    with MockPlatformInterfaceMixin
    implements GtmIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GtmIosPlatform initialPlatform = GtmIosPlatform.instance;

  test('$MethodChannelGtmIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGtmIos>());
  });

  test('getPlatformVersion', () async {
    GtmIos gtmIosPlugin = GtmIos();
    MockGtmIosPlatform fakePlatform = MockGtmIosPlatform();
    GtmIosPlatform.instance = fakePlatform;

    expect(await gtmIosPlugin.getPlatformVersion(), '42');
  });
}
