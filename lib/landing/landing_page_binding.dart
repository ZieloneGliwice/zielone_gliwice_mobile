import 'package:get/get.dart';

import '../camera/camera_page.dart';
import 'landing_page.dart';

class LandingPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandingPageController>(() => LandingPageController());
    Get.lazyPut<CameraPageController>(() => CameraPageController(), fenix: true);
  }
}