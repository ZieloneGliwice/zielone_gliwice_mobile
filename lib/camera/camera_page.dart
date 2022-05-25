import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/dimen.dart';
import '../ui/styles.dart';

class CameraPage extends GetView<CameraPageController> {
  const CameraPage({super.key});

  static const String path = '/camera_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    return Center(child: Text('no_photo_selected'.tr));
  }

  Widget _cropping(XFile imageFile) {
    return Column(
      children: <Widget>[
        Expanded(
            child: CropImage(
                controller: controller.croppingController,
                image: Image.file(File(imageFile.path),
                  fit: BoxFit.fill,
                )
            )
        ),
        _bottomMenu(),
      ],
    );
  }

  Widget _bottomMenu() {
    return Container(
      color: ApplicationColors.black,
      child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              controller.resetCropping();
              },
            child: Text('reset_uppercased'.tr, style: ApplicationTextStyles.textButtonTextStyle),
          ),
          const SizedBox(height: Dimen.marginNormal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(width: Dimen.marginNormal),
              _retakeButton(),
              const SizedBox(width: Dimen.marginSmall),
              _readyButton(),
              const SizedBox(width: Dimen.marginNormal),
            ],
          ),
          const SizedBox(height: Dimen.marginNormal),
        ],
      ),
    );
  }

  Widget _retakeButton() {
    return Expanded(
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
          child: OutlinedButton(
              onPressed: () { controller.getFromCamera(); },
              style: WhiteOvalButtonStyle(),
              child: Text('retake'.tr)
          )
      ),
    );
  }

  Widget _readyButton() {
    return Expanded(
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
          child: OutlinedButton(
              onPressed: () { controller.finished(); },
              style: GreenOvalButtonStyle(),
              child: Text('ready'.tr)
          )
      ),
    );
  }
}

class CameraPageController extends GetxController with StateMixin<XFile> {
  final ImagePicker _picker = ImagePicker();
  CropController? croppingController;

  @override
  void onInit() {
    change(null, status: RxStatus.loading());
    getFromCamera();
    super.onInit();
  }

  Future<void> getFromCamera() async {
    change(null, status: RxStatus.loading());
    try {
      croppingController = CropController();
      final XFile? selectedImage = await _picker.pickImage(source: ImageSource.camera);
      change(selectedImage, status: RxStatus.success());
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  Future<void> finished() async {
    final BuildContext? context = Get.context;

    if (context != null) {
      change(null, status: RxStatus.loading());
      final File savedFile = await cropAndStorePhoto();

      Get.back(result: savedFile.path);
    } else {
      change(null, status: RxStatus.error('Something went wrong please try again'));
    }
  }

  Future<File> cropAndStorePhoto() async {
    final ui.Image? image = await croppingController?.croppedBitmap();
    final ByteData? data = await image?.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List? bytes = data?.buffer.asUint8List();

    final Directory temporaryDirectory = await getTemporaryDirectory();
    final String fileName = Get.arguments as String;
    final String fullPath = '${temporaryDirectory.path}/$fileName.png';

    final File imgFile = File(fullPath);
    final File savedFile = await imgFile.writeAsBytes(bytes!);
    return savedFile;
  }

  void resetCropping() {
    croppingController?.crop = const Rect.fromLTWH(0, 0, 1, 1);
  }
}
