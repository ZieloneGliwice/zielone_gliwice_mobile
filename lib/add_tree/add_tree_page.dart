import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('add_tree_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: Padding(
        padding: const EdgeInsets.all(Dimen.marginNormal),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <SliverFillRemaining>[
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: <Widget>[
                  PhotoPickerWidget(TreePhotoType.tree, 'take_tree_photo_title'.tr, 'take_tree_photo_body'.tr),
                  _space(),
                  PhotoPickerWidget(TreePhotoType.leaf, 'take_leaf_photo_title'.tr, 'take_leaf_photo_body'.tr),
                  _space(),
                  PhotoPickerWidget(TreePhotoType.bark, 'take_bark_photo_title'.tr, 'take_bark_photo_body'.tr),
                  _space(),
                  const Spacer(),
                  _button()
                ],
              ),
            )
          ]
        ),
      ),
    );
  }

  Widget _space() {
    return const SizedBox(height: Dimen.marginNormal);
  }

  Widget _button() {
    return Obx(() {
      final bool isEnabled = controller.hasRequiredPhotos();
      return PrimaryButton(title: 'next'.tr, isEnabled: isEnabled, onTap: proceed,);
    });
  }

  void proceed() {
      Get.toNamed(NewTreePage.path);
  }
}

class AddTreePageController extends GetxController {
  Rxn<File> treePhoto = Rxn<File>();
  Rxn<File> leafPhoto = Rxn<File>();
  Rxn<File> barkPhoto = Rxn<File>();

  bool hasRequiredPhotos() {
    return treePhoto.value != null && leafPhoto.value != null;
  }
}
