import 'dart:ffi';
import 'dart:io';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends GetView<CameraPageController> {
  const CameraPage({super.key});

  static const String path = '/camera_page';

  @override
  Widget build(BuildContext context) {
    Get.snackbar('Wykonaj zdjęcie drzewa', 'Wukonaj je!');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zielone Gliwice'),
      ),
      body: controller.obx((XFile? imageFile) {
        if (imageFile != null) {
          return _cropping(imageFile);
        } else {
          return _noPhotoSelected();
        }
      },
      onLoading: const Center(child: CircularProgressIndicator(),),
      onError: (String? error) => Center(child:Text(error ?? '')),
      onEmpty: _noPhotoSelected()),
    );
  }

  Widget _noPhotoSelected() {
    return const Center(child: Text('No photo selected'));
  }

  Widget _cropping(XFile imageFile) {
    return Center(
      child: Column(
        children: [
          const Text('Zaznacz obszar do analizy'),
          CropImage(controller: controller.croppingController, image: Image.file(File(imageFile.path))),
          OutlinedButton(onPressed: () => controller.finished(), child: const Text('Dalej'))
        ],
      ),
    );
  }
}

class CameraPageController extends GetxController with StateMixin<XFile> {
  final ImagePicker _picker = ImagePicker();
  final CropController croppingController = CropController();

  @override
  void onInit() {
    _getFromCamera();
    super.onInit();
  }

  Future<void> _getFromCamera() async {
    change(null, status: RxStatus.loading());
    try {
      final XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
      change(selectedImage, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  Future<void> finished() async {
    final context = Get.context;

    if (context != null) {
      final image = await croppingController.croppedImage();
    } else {
      change(null, status: RxStatus.error('Something went wrong please try again'));
    }
  }
}