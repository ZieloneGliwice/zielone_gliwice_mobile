import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'camera_page.dart';

class CameraPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePicker>(() => ImagePicker(), fenix: true);
    Get.lazyPut<CameraPageController>(() => CameraPageController(Get.find()), fenix: true);
  }
}
