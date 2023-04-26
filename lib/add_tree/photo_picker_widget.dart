import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../camera/camera_page.dart';
import '../ui/dimen.dart';
import '../ui/styles.dart';
import 'add_tree_page.dart';
import 'tree_photo_type.dart';

class PhotoPickerWidget extends StatelessWidget {
  const PhotoPickerWidget(
      this.photoType, this.descriptionTitle, this.descriptionBody,
      {super.key});

  final TreePhotoType photoType;
  final String descriptionTitle;
  final String descriptionBody;

  @override
  Widget build(BuildContext context) {
    final PhotoPickerWidgetController controller =
        Get.find(tag: photoType.name);

    return ElevatedButton(
        onPressed: () {
          controller.takePhoto(photoType);
        },
        clipBehavior: Clip.hardEdge,
        style: PhotoPlaceholderButtonStyle(),
        child: Obx(() {
          if (controller.photoPath.value.isNotEmpty) {
            return Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.85,
                  child: Image.file(
                  File(controller.photoPath.value),
                  fit: BoxFit.cover,
              ),
                ),
                Positioned(
                    bottom: 8,
                    right: 8,
                    child: SvgPicture.asset('assets/images/checkmark-enabled.svg', height: 32, width: 32,)),
                ]
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimen.marginNormal),
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.camera_alt_outlined,
                      color: ApplicationColors.white,
                      size: 40,
                    ),
                    const SizedBox(height: Dimen.marginSmall),
                    Text(
                      descriptionTitle,
                      style: ApplicationTextStyles.placeholderHeaderTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Dimen.marginTiny),
                    Text(
                      descriptionBody,
                      style: ApplicationTextStyles.placeholderContentTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }
}

class PhotoPickerWidgetController extends GetxController {
  PhotoPickerWidgetController(this.addTreePageController);

  RxString photoPath = ''.obs;

  final AddTreePageController addTreePageController;

  Future<void> takePhoto(TreePhotoType photoType) async {
    final String photoPath =
        await Get.toNamed(CameraPage.path, arguments: photoType.name)
            as String? ?? '';

    final File? file = photoPath.isNotEmpty ? File(photoPath) : null;

    switch (photoType) {
      case TreePhotoType.leaf:
        addTreePageController.leafPhoto.value = file;
        break;
      case TreePhotoType.tree:
        addTreePageController.treePhoto.value = file;
        break;
      case TreePhotoType.bark:
        addTreePageController.barkPhoto.value = file;
        break;
    }

    this.photoPath.value = photoPath;
  }
}
