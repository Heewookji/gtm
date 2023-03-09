import 'package:gtm_platform_interface/gtm_platform_interface.dart';

class Gtm {
  static Gtm? _instance;
  static Gtm get instance => _instance ??= Gtm._();

  Gtm._();

  void setCustomTagTypes(List<CustomTagType> tagTypes) {
    GtmPlatform.instance.setCustomTagTypes(tagTypes);
  }

  Future<bool> push(
    String eventName, {
    required Map<String, dynamic> parameters,
  }) {
    return GtmPlatform.instance.push(eventName, parameters: parameters);
  }
}
