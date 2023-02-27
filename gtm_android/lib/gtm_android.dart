
import 'gtm_android_platform_interface.dart';

class GtmAndroid {
  Future<String?> getPlatformVersion() {
    return GtmAndroidPlatform.instance.getPlatformVersion();
  }
}
