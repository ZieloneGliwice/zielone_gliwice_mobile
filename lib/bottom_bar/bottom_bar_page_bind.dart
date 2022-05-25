import 'package:get/get.dart';

import '../add_tree/add_tree_page.dart';
import '../add_tree/photo_picker_widget.dart';
import '../add_tree/tree_photo_type.dart';
import 'bottom_bar_page.dart';

class BottomBarPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarPageController>(() => BottomBarPageController());
    Get.lazyPut(() => PhotoPickerWidgetController(), fenix: true, tag: TreePhotoType.tree.toString());
    Get.lazyPut(() => PhotoPickerWidgetController(), fenix: true, tag: TreePhotoType.leaf.toString());
    Get.lazyPut(() => PhotoPickerWidgetController(), fenix: true, tag: TreePhotoType.bark.toString());
    Get.lazyPut<AddTreePageController>(() => AddTreePageController(), fenix: true);
  }
}