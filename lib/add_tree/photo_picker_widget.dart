import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../camera/camera_page.dart';
import '../ui/styles.dart';
import 'add_tree_page.dart';
import 'tree_photo_type.dart';

class PhotoPickerWidget extends StatelessWidget {
  const PhotoPickerWidget(this.photoType, {super.key});

  final TreePhotoType photoType;

  @override
  Widget build(BuildContext context) {
    final PhotoPickerWidgetController controller = Get.find(tag: photoType.toString());

    return ElevatedButton(
        onPressed: () {
          controller.takePhoto(photoType);
        },
        clipBehavior: Clip.hardEdge,
        style: PhotoPlaceholderButtonStyle(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 70, minWidth: double.infinity),
          child: Obx(() {
            if (controller.photoPath.value.isNotEmpty) {
              return Image.file(
                File(controller.photoPath.value),
                fit: BoxFit.fitWidth,
              );
            } else {
              return const Center(
                child: Icon(Icons.camera_alt_outlined,
                  color: ApplicationColors.white,
                  size: 50,
                ),
              );
            }
          }),
        )
    );
  }
}

class PhotoPickerWidgetController extends GetxController {
  RxString photoPath = ''.obs;

  final AddTreePageController addTreePageController = Get.find();

  Future<void> takePhoto(TreePhotoType photoType) async {
    photoPath.value = await Get.toNamed(CameraPage.path, arguments: photoType.toString()) as String;

    switch (photoType) {
      case TreePhotoType.leaf:
        addTreePageController.leafPhotoPath.value = photoPath.value;
        break;
      case TreePhotoType.tree:
        addTreePageController.treePhotoPath.value = photoPath.value;
        break;
      case TreePhotoType.bark:
        addTreePageController.barkPhotoPath.value = photoPath.value;
        break;
    }
  }
}
