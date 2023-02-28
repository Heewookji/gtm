// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:gtm_platform_interface/gtm_platform_interface.dart';

class Gtm {
  static Gtm? _instance;
  static Gtm get instance => _instance ??= Gtm._();

  Gtm._();

  Future<String?> getPlatformVersion() {
    return GtmPlatform.instance.getPlatformVersion();
  }
}
