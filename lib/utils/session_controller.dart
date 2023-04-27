import 'package:get/get.dart';
import '../log_in/log_in_page.dart';
import '../services/photos_service.dart';
import 'session_storage.dart';

class SessionController extends GetxController {
  SessionController(this.sessionStorage, this.photosService);

  final SessionStorage sessionStorage;
  final PhotosService photosService;

  void unauthorized() {
    Get.showSnackbar(GetSnackBar(title: 'error'.tr, message: 'session_expired'.tr, duration: const Duration(seconds: 5)));
    logout();
  }

  Future<void> logout() async {
    await clearUserData();
    await sessionStorage.clear();
    Get.offAllNamed(LogInPage.path);
  }

  Future<void> clearUserData() async {
    await photosService.clearCachedPhotos();
  }
}
