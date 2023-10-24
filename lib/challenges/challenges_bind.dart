import 'package:get/get.dart';

import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'challenges_page.dart';

class ChallengesPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => ChallengesPageController(Get.find(), Get.find()),
        fenix: true);
  }
}
