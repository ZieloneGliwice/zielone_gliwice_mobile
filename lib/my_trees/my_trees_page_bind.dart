import 'package:get/get.dart';

import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../utils/session_storage.dart';
import 'my_trees_page.dart';

class MyTreesPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut(() => MyTreesProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => MyTreesController(Get.find(), Get.find()), fenix: true);
  }
}
