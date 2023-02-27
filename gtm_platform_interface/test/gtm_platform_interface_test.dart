import 'package:flutter_test/flutter_test.dart';
import 'package:gtm_platform_interface/gtm_platform_interface.dart';
import 'package:gtm_platform_interface/gtm_platform_interface_platform_interface.dart';
import 'package:gtm_platform_interface/gtm_platform_interface_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGtmPlatformInterfacePlatform
    with MockPlatformInterfaceMixin
    implements GtmPlatformInterfacePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GtmPlatformInterfacePlatform initialPlatform = GtmPlatformInterfacePlatform.instance;

  test('$MethodChannelGtmPlatformInterface is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGtmPlatformInterface>());
  });

  test('getPlatformVersion', () async {
    GtmPlatformInterface gtmPlatformInterfacePlugin = GtmPlatformInterface();
    MockGtmPlatformInterfacePlatform fakePlatform = MockGtmPlatformInterfacePlatform();
    GtmPlatformInterfacePlatform.instance = fakePlatform;

    expect(await gtmPlatformInterfacePlugin.getPlatformVersion(), '42');
  });
}
