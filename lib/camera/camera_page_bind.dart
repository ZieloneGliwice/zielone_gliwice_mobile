import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/photos_service.dart';
import 'camera_page.dart';

class CameraPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImagePicker>(() => ImagePicker(), fenix: true);
    Get.lazyPut<PhotosService>(() => PhotosService(), fenix: true);
    Get.lazyPut<CameraPageController>(() => CameraPageController(Get.find(), Get.find()), fenix: true);
  }
}
