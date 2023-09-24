import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'schools_selection_page.dart';

class SchoolsSelectionBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => TextEditingController(), fenix: true);
    Get.lazyPut(
        () => SchoolsSelectionController(Get.find(), Get.find(), Get.find()),
        fenix: true);
  }
}
