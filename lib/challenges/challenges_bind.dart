import 'package:get/get.dart';

import '../network/leaderboard_entries_provider.dart';
import '../network/my_leaderboard_entry_provider.dart';
import '../services/photos_service.dart';
import '../utils/session_storage.dart';
import 'challenges_page.dart';

class ChallengesPageBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhotosService(), fenix: true);
    Get.lazyPut(() => SessionStorage(), fenix: true);
    Get.lazyPut(() => EntriesProvider(Get.find(), Get.find()), fenix: true);
    Get.lazyPut(() => MyEntryProvider(Get.find(), Get.find()), fenix: true);

    Get.lazyPut(
        () => ChallengesPageController(
            Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);
  }
}
