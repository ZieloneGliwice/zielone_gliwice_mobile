import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../analytics/analytics.dart';
import '../new_tree/new_tree_page.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import 'photo_picker_widget.dart';
import 'tree_photo_type.dart';

class AddTreePage extends GetView<AddTreePageController> {
  const AddTreePage({super.key});

  static const String path = '/add_tree_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(AddTreePage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('add_tree_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimen.marginNormal),
        child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <SliverFillRemaining>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: Dimen.marginNormalPlus,
                    ),
                    Text.rich(TextSpan(
                        style: ApplicationTextStyles.descriptionTextStyle,
                        children: <TextSpan>[
                          TextSpan(text: 'add_tree_photos_description_1'.tr),
                          TextSpan(
                              text: 'add_tree_photos_description_2'.tr,
                              style: ApplicationTextStyles
                                  .descriptionBoldTextStyle),
                          TextSpan(text: 'add_tree_photos_description_3'.tr),
                          TextSpan(
                              text: 'add_tree_photos_description_4'.tr,
                              style: ApplicationTextStyles
                                  .descriptionBoldTextStyle),
                        ])),
                    _space(),
                    PhotoPickerWidget(TreePhotoType.tree,
                        'take_tree_photo_title'.tr, 'take_tree_photo_body'.tr),
                    _space(),
                    PhotoPickerWidget(TreePhotoType.leaf,
                        'take_leaf_photo_title'.tr, 'take_leaf_photo_body'.tr),
                    _space(),
                    PhotoPickerWidget(TreePhotoType.bark,
                        'take_bark_photo_title'.tr, 'take_bark_photo_body'.tr),
                    _space(),
                    const Spacer(),
                    _button(),
                    const SizedBox(
                      height: Dimen.marginNormalPlus,
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  Widget _space() {
    return const SizedBox(height: Dimen.marginNormal);
  }

  Widget _button() {
    return Obx(() {
      final bool isEnabled = controller.hasRequiredPhotos();
      return PrimaryButton(
        title: 'next'.tr,
        isEnabled: isEnabled,
        onTap: proceed,
      );
    });
  }

  void proceed() {
    Analytics.buttonPressed('Proceed');
    Analytics.logEvent('${AddTreePage.path}: Proceed');
    Get.toNamed(NewTreePage.path, arguments: controller.args);
  }
}

class AddTreePageController extends GetxController {
  Rxn<File> treePhoto = Rxn<File>();
  Rxn<File> leafPhoto = Rxn<File>();
  Rxn<File> barkPhoto = Rxn<File>();

  dynamic args = Get.arguments;

  bool hasRequiredPhotos() {
    return treePhoto.value != null && leafPhoto.value != null;
  }
}
