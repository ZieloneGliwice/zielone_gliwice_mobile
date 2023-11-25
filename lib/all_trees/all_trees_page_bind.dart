import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'all_trees_page.dart';

class AllTreesPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => MyTreesProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => AllTreesController(Get.find(), Get.find(), Get.find()),
        fenix: true);
  }
}
