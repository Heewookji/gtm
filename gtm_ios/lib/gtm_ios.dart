
import 'gtm_ios_platform_interface.dart';

class GtmIos {
  Future<String?> getPlatformVersion() {
    return GtmIosPlatform.instance.getPlatformVersion();
  }
}
