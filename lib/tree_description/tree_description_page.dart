import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';

class TreeDescriptionPage extends GetView<TreeDescriptionController> {
  const TreeDescriptionPage({super.key});

  static const String path = '/tree_description';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('tree_description_title'.tr),
      ),
      backgroundColor: ApplicationColors.white,
      body: SafeArea(
          child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <SliverFillRemaining>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
              child: Column(
                children: <Widget>[
                  Text.rich(TextSpan(
                      style: ApplicationTextStyles.descriptionTextStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text: '${'tree_description_explanation_1'.tr}\n\n'),
                        TextSpan(
                            text: 'tree_description_explanation_2'.tr,
                            style:
                                ApplicationTextStyles.descriptionBoldTextStyle),
                        TextSpan(text: 'tree_description_explanation_3'.tr),
                      ])),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: controller._descriptionController,
                      decoration: InputDecoration(
                          hintText: 'tree_description_hint'.tr,
                          hintStyle: ApplicationTextStyles.hintTextStyle,
                          enabledBorder: _underlineDecorator(),
                          errorBorder: _underlineDecorator(),
                          focusedBorder: _underlineDecorator(),
                          border: _underlineDecorator()),
                      keyboardType: TextInputType.multiline,
                      style: ApplicationTextStyles.bodyTextStyle,
                      maxLines: null,
                      expands: true,
                    ),
                  ),
                  const SizedBox(
                    height: Dimen.marginSmall,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: PrimaryButton(title: 'save'.tr, isEnabled: true, onTap: controller.save)
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  UnderlineInputBorder _underlineDecorator() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: ApplicationColors.silver, width: 0.4));
  }
}

class TreeDescriptionController extends GetxController {
  TreeDescriptionController(this._descriptionController);

  final TextEditingController _descriptionController;

  @override
  void onInit() {
    super.onInit();
    final String? description = Get.arguments as String?;
    _descriptionController.text = description ?? '';
  }

  void save() {
    Get.back(result: _descriptionController.text);
  }
}
