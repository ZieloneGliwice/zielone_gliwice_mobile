import 'package:get/get.dart';

import '../network/my_leaderboard_entry_delete_provider.dart';
import '../network/my_trees_delete_provider.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'settings_page.dart';

class SettingsPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => MyTreesDeleteProvider(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(() => MyLeaderboardEntryDeleteProvider(Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () => SettingsPageController(
            Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);
  }
}
