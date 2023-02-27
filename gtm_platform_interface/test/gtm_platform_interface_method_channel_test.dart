import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gtm_platform_interface/gtm_platform_interface_method_channel.dart';

void main() {
  MethodChannelGtmPlatformInterface platform = MethodChannelGtmPlatformInterface();
  const MethodChannel channel = MethodChannel('gtm_platform_interface');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
