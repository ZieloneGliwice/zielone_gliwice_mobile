import 'package:get/get.dart';
import '../log_in/log_in_page.dart';
import 'session_storage.dart';

class SessionController extends GetxController {
  SessionController(this.sessionStorage);

  final SessionStorage sessionStorage;

  void unauthorized() {
    Get.showSnackbar(GetSnackBar(title: 'error'.tr, message: 'session_expired'.tr, duration: const Duration(seconds: 5)));
    logout();
  }

  Future<void> logout() async {
    await sessionStorage.clear();
    Get.offAllNamed(LogInPage.path);
  }
}
