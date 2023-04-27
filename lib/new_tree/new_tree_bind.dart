import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'new_tree_page.dart';
import 'new_tree_request.dart';

class NewTreeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => AddTreePageController(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => NewTreeRequest(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => NewTreeController(Get.find(), Get.find(), Get.find(), Get.find()), fenix: true);
  }
}
