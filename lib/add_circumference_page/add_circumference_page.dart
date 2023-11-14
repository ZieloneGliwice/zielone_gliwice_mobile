import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../analytics/analytics.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';

class AddTreeCircumferencePage extends GetView<AddTreeCircumferenceController> {
  const AddTreeCircumferencePage({super.key});

  static const String path = '/circumference';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(AddTreeCircumferencePage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('add_circumference_title'.tr),
      ),
      backgroundColor: ApplicationColors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Column(
                  children: <Widget>[
                    Text.rich(TextSpan(
                        style: ApplicationTextStyles.descriptionTextStyle,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '${'add_circumference_description_1'.tr}\n\n'),
                          TextSpan(
                              text: 'add_circumference_description_2'.tr,
                              style: ApplicationTextStyles
                                  .descriptionBoldTextStyle),
                          TextSpan(
                              text: '${'add_circumference_description_3'.tr} '),
                        ])),
                    TextField(
                      controller: controller.inputController,
                      decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: ApplicationTextStyles.valueHintInputStyle,
                          enabledBorder: _underlineDecorator(),
                          errorBorder: _underlineDecorator(),
                          focusedBorder: _underlineDecorator(),
                          border: _underlineDecorator()),
                      keyboardType: TextInputType.number,
                      style: ApplicationTextStyles.valueInputStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: Dimen.marginSmall,
                    ),
                    const Text(
                      '[cm]',
                      style: ApplicationTextStyles.valueInputUnitStyle,
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: Dimen.marginSmall,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: PrimaryButton(
                            title: 'save'.tr,
                            isEnabled: true,
                            onTap: controller.save))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder _underlineDecorator() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent));
  }
}

class AddTreeCircumferenceController extends GetxController {
  AddTreeCircumferenceController(this.inputController);

  final TextEditingController inputController;

  @override
  void onInit() {
    super.onInit();
    final String? value = Get.arguments as String?;
    inputController.text = value ?? '';
  }

  void save() {
    Analytics.buttonPressed('Save');
    Analytics.logEvent('${AddTreeCircumferencePage.path}: Save circumference');
    Get.back(result: inputController.text);
  }
}
