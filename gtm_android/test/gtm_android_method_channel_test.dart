import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gtm_android/gtm_android_method_channel.dart';

void main() {
  MethodChannelGtmAndroid platform = MethodChannelGtmAndroid();
  const MethodChannel channel = MethodChannel('gtm_android');

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
