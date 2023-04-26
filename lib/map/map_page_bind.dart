import 'dart:async';

import 'package:get/get.dart';
import 'package:location/location.dart';

import 'map_page.dart';

class MapPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Location(), fenix: true);
    Get.lazyPut(() => MapPageController(Get.find()), fenix: true);
  }
}
