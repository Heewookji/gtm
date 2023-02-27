import 'package:flutter_test/flutter_test.dart';
import 'package:gtm/gtm.dart';
import 'package:gtm/gtm_platform_interface.dart';
import 'package:gtm/gtm_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockGtmPlatform
    with MockPlatformInterfaceMixin
    implements GtmPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final GtmPlatform initialPlatform = GtmPlatform.instance;

  test('$MethodChannelGtm is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelGtm>());
  });

  test('getPlatformVersion', () async {
    Gtm gtmPlugin = Gtm();
    MockGtmPlatform fakePlatform = MockGtmPlatform();
    GtmPlatform.instance = fakePlatform;

    expect(await gtmPlugin.getPlatformVersion(), '42');
  });
}
