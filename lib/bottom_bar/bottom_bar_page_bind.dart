import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../add_tree/photo_picker_widget.dart';
import '../add_tree/tree_photo_type.dart';
import '../my_trees/my_trees_page.dart';
import '../network/api_dio.dart';
import '../network/my_trees_provider.dart';
import '../utils/session_storage.dart';
import 'bottom_bar_page.dart';

class BottomBarPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ApiDio(), fenix: true);
    Get.lazyPut<BottomBarPageController>(() => BottomBarPageController(Get.find()));
    Get.lazyPut(() => MyTreesProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => MyTreesController(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => AddTreePageController(), fenix: true);
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.tree.name);
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.leaf.name);
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.bark.name);
    Get.lazyPut<AddTreePageController>(() => AddTreePageController(), fenix: true);
  }
}
