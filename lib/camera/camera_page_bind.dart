import 'package:get/get.dart';

import 'camera_page.dart';

class CameraPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraPageController>(() => CameraPageController(), fenix: true);
  }
}