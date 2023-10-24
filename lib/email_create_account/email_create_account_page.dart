import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';

class EmailCreateAccountPage extends GetView<EmailCreateAccountPageController> {
  const EmailCreateAccountPage({super.key});
  static const String path = '/email_create_account_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('create_account'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Theme(
                data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      prefixIconColor: ApplicationColors.gray,
                    ),
                    textSelectionTheme: const TextSelectionThemeData(
                        cursorColor: ApplicationColors.green)),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 30),
                      _logo(),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: controller.nameController,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          floatingLabelStyle:
                              const TextStyle(color: ApplicationColors.green),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ApplicationColors.green),
                          ),
                          label: Text('name'.tr),
                          prefixIcon: const Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: controller.emailController,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          floatingLabelStyle:
                              const TextStyle(color: ApplicationColors.green),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: ApplicationColors.green),
                          ),
                          label: Text('email_adress'.tr),
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Obx(
                        () => TextFormField(
                          controller: controller.passwordController,
                          style: const TextStyle(fontSize: 18),
                          obscureText: controller.passwordHidden.value,
                          decoration: InputDecoration(
                            floatingLabelStyle:
                                const TextStyle(color: ApplicationColors.green),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: ApplicationColors.green),
                            ),
                            label: Text('password'.tr),
                            prefixIcon: const Icon(Icons.fingerprint),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  controller.passwordHidden.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ApplicationColors.gray),
                              onPressed: () {
                                controller.passwordHidden.value =
                                    !controller.passwordHidden.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ApplicationColors.green,
                            ),
                            onPressed: () => controller.signUserUp(context),
                            child: Text(
                              'create_account'.tr,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _logo() {
    const String assetName = 'assets/images/full_logo.png';
    return const Image(image: AssetImage(assetName));
  }
}

class EmailCreateAccountPageController extends SessionController
    with StateMixin<bool> {
  EmailCreateAccountPageController(super.sessionStorage, super.photosService);

  RxBool passwordHidden = true.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // getData();
  }

  // Future<void> getData() async {

  // }

  Future<void> signUserUp(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      final User? user = userCredential.user;
      user?.updateDisplayName(nameController.text);

      Navigator.pop(context);
      Get.back();
      showMessage('account_created'.tr, context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      switch (e.code) {
        case 'channel-error':
          showMessage('complete_data'.tr, context);
          break;
        case 'email-already-in-use':
          showMessage('email_in_use'.tr, context);
          break;
        case 'weak-password':
          showMessage('weak_password'.tr, context);
          break;
        case 'invalid-email':
          showMessage('invalid_email'.tr, context);
          break;
        default:
          showMessage(e.code, context);
      }
    }
  }

  showMessage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ApplicationColors.green,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
