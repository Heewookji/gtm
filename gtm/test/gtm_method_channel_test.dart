import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gtm/gtm_method_channel.dart';

void main() {
  MethodChannelGtm platform = MethodChannelGtm();
  const MethodChannel channel = MethodChannel('gtm');

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
