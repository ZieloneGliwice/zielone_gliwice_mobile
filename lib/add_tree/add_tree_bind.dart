import 'package:get/get.dart';

import 'add_tree_page.dart';
import 'photo_picker_widget.dart';
import 'tree_photo_type.dart';

class AddTreePageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.tree.name);
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.leaf.name);
    Get.lazyPut(() => PhotoPickerWidgetController(Get.find()), fenix: true, tag: TreePhotoType.bark.name);
    Get.lazyPut<AddTreePageController>(() => AddTreePageController(), fenix: true);
  }
}