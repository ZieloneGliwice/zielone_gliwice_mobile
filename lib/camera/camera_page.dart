import 'dart:io';
import 'dart:ui' as ui;

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../model/errors.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/styles.dart';

class CameraPage extends GetView<CameraPageController> {
  const CameraPage({super.key});

  static const String path = '/camera_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.obx((String? path) {
        if (path != null) {
          return _cropping(path);
        } else {
          return _noPhotoSelected();
        }
      },
          onLoading: const ActivityIndicator(),
          onError: (String? error) => ErrorView.from(
                CameraDeniedError(),
                controller.goBack,
                buttonTitle: 'go_back'.tr,
              ),
          onEmpty: _noPhotoSelected()),
    );
  }

  Widget _noPhotoSelected() {
    return _noPhoto('no_photo_selected'.tr);
  }

  Widget _cropping(String path) {
    return Container(
      color: ApplicationColors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            child: CropImage(
              controller: controller.croppingController,
              image: Image.file(
                File(path),
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          _bottomMenu(),
        ],
      ),
    );
  }

  Widget _noPhoto(String message) {
    return Column(
      children: <Widget>[
        const Spacer(),
        const Icon(Icons.photo_camera,
            color: ApplicationColors.silver, size: 75),
        Center(
            child: Text(
          message,
          style: ApplicationTextStyles.descriptionTextStyle,
        )),
        const Spacer(),
        _emptyBottomMenu(),
      ],
    );
  }

  Widget _bottomMenu() {
    return Container(
      color: ApplicationColors.black,
      child: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
                controller.resetCropping();
              },
              child: Text('reset_uppercased'.tr,
                  style: ApplicationTextStyles.textButtonTextStyle),
            ),
            //const SizedBox(height: Dimen.marginNormal),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(width: Dimen.marginNormal),
                _retakeButton(WhiteOvalButtonStyle()),
                const SizedBox(width: Dimen.marginSmall),
                _readyButton(),
                const SizedBox(width: Dimen.marginNormal),
              ],
            ),
            const SizedBox(height: Dimen.marginNormal),
          ],
        ),
      ),
    );
  }

  Widget _emptyBottomMenu() {
    return Container(
      color: ApplicationColors.black,
      child: SafeArea(
        top: false,
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
                controller.resetCropping();
              },
              child: Text('reset_uppercased'.tr,
                  style: ApplicationTextStyles.textButtonTextStyle),
            ),
            //const SizedBox(height: Dimen.marginNormal),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(width: Dimen.marginNormal),
                _backButton(),
                const SizedBox(width: Dimen.marginSmall),
                _retakeButton(GreenOvalButtonStyle()),
                const SizedBox(width: Dimen.marginNormal),
              ],
            ),
            const SizedBox(height: Dimen.marginNormal),
          ],
        ),
      ),
    );
  }

  Widget _retakeButton(ButtonStyle style) {
    return Expanded(
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
          child: ElevatedButton(
              onPressed: () {
                controller.getFromCamera();
              },
              style: style,
              child: Text('retake'.tr))),
    );
  }

  Widget _readyButton() {
    return Expanded(
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
          child: ElevatedButton(
              onPressed: () {
                controller.finished();
              },
              style: GreenOvalButtonStyle(),
              child: Text('ready'.tr))),
    );
  }

  Widget _backButton() {
    return Expanded(
      child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
          child: ElevatedButton(
              onPressed: () {
                controller.goBack();
              },
              style: WhiteOvalButtonStyle(),
              child: Text('go_back'.tr))),
    );
  }
}

class CameraPageController extends GetxController with StateMixin<String> {
  CameraPageController(this._picker, this._photosService);

  final ImagePicker _picker;
  final PhotosService _photosService;
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
      final XFile? selectedImage =
          await _picker.pickImage(source: ImageSource.camera);
      change(selectedImage?.path, status: RxStatus.success());
    } on PlatformException catch (error) {
      change(null, status: RxStatus.error(error.toString()));
    }
  }

  Future<void> finished() async {
    final BuildContext? context = Get.context;

    if (context != null) {
      change(null, status: RxStatus.loading());
      final String imagePath = await cropAndStorePhoto();
      Get.back(result: imagePath);
    } else {
      change(null,
          status: RxStatus.error('Something went wrong please try again'));
    }
  }

  Future<String> cropAndStorePhoto() async {
    final String filaName = Get.arguments as String? ?? 'image';
    final ui.Image? image = await croppingController?.croppedBitmap();

    return _photosService.storePhoto(filaName, image);
  }

  void resetCropping() {
    croppingController?.crop = const Rect.fromLTWH(0, 0, 1, 1);
  }

  void goBack() {
    Get.back();
  }
}
