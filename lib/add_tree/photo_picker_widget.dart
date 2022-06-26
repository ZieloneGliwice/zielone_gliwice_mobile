import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../camera/camera_page.dart';
import '../ui/dimen.dart';
import '../ui/styles.dart';
import 'add_tree_page.dart';
import 'tree_photo_type.dart';

class PhotoPickerWidget extends StatelessWidget {
  const PhotoPickerWidget(this.photoType, this.descriptionTitle, this.descriptionBody, {super.key});

  final TreePhotoType photoType;
  final String descriptionTitle;
  final String descriptionBody;

  @override
  Widget build(BuildContext context) {
    final PhotoPickerWidgetController controller = Get.find(tag: photoType.toString());

    return ElevatedButton(
        onPressed: () {
          controller.takePhoto(photoType);
        },
        clipBehavior: Clip.hardEdge,
        style: PhotoPlaceholderButtonStyle(),
        child: Obx(() {
          if (controller.photoPath.value.isNotEmpty) {
            return Image.file(
              File(controller.photoPath.value),
              fit: BoxFit.fitWidth,
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(Dimen.marginNormal),
                child: Column(
                  children: <Widget>[
                    const Icon(Icons.camera_alt_outlined,
                      color: ApplicationColors.white,
                      size: 40,
                    ),
                    const SizedBox(height: Dimen.marginSmall),
                    Text(descriptionTitle, style: ApplicationTextStyles.placeholderHeaderTextStyle, textAlign: TextAlign.center,),
                    const SizedBox(height: Dimen.marginTiny),
                    Text(descriptionBody, style: ApplicationTextStyles.placeholderContentTextStyle, textAlign: TextAlign.center,),
                  ],
                ),
              ),
            );
          }
        })
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
