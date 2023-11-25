import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../add_circumference_page/add_circumference_page.dart';
import '../add_tree/add_tree_page.dart';
import '../add_tree_condition/add_tree_condition_page.dart';
import '../analytics/analytics.dart';
import '../map/map_page.dart';
import '../model/dictionary_object.dart';
import '../model/errors.dart';
import '../model/new_tree.dart';
import '../my_trees/my_trees_page.dart';
import '../network/api_dio.dart';
import '../services/photos_service.dart';
import '../species_selection/species_selection_page.dart';
import '../tree_description/tree_description_page.dart';
import '../ui/dimen.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';
import 'new_tree_request.dart';

class NewTreePage extends GetView<NewTreeController> {
  const NewTreePage({super.key});

  static const String path = '/next_tree_page';

  @override
  Widget build(BuildContext context) {
    Analytics.visitedScreen(NewTreePage.path);
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('my_tree_title'.tr),
      ),
      backgroundColor: ApplicationColors.background,
      body: controller.obx((_) {
        return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: <SliverFillRemaining>[
              SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      _gallery(),
                      _selectSpeciesWidget(),
                      _addDescriptionWidget(),
                      _addTreeCircumferenceWidget(),
                      _addTreeConditionWidget(),
                      _addTreeLocationWidget(),
                      const SizedBox(
                        height: Dimen.marginBig,
                      ),
                      const Spacer(),
                      _button(),
                      const SizedBox(
                        height: Dimen.marginNormalPlus,
                      ),
                    ],
                  ),
                ),
              )
            ]);
      }, onLoading: _loading()),
    );
  }

  Widget _gallery() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.all(Dimen.marginNormal),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (controller.mainPhoto.value.isNotEmpty) ...<Widget>{
              Expanded(child: _image(controller.mainPhoto.value))
            },
            const SizedBox(width: Dimen.marginSmall),
            _thumbnails()
          ],
        ),
      ),
    );
  }

  Column _thumbnails() {
    const double thumbnailSize = 58.0;
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < controller.thumbnails.length; i++) ...<Widget>[
            GestureDetector(
              onTap: () {
                Analytics.buttonPressed('Take Photo Thumbnail');
                Analytics.logEvent('${NewTreePage.path}: Change photo preview');
                controller.focusOnPhoto(controller.thumbnails[i]);
              },
              child: SizedBox(
                  height: thumbnailSize,
                  width: thumbnailSize,
                  child: _image(controller.thumbnails[i])),
            ),
            const SizedBox(height: Dimen.marginNormal),
          ]
        ]);
  }

  Widget _image(String path) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      clipBehavior: Clip.hardEdge,
      child: Image.file(
        File(path),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _selectSpeciesWidget() {
    return Obx(() {
      final String title = controller.selectedSpecie.value?.name?.capitalize ??
          'enter_the_tree_species'.tr;
      final bool isEnabled = controller.selectedSpecie.value != null;
      return _detailWidget(title, isEnabled, () {
        controller.selectSpecies();
      });
    });
  }

  Widget _addDescriptionWidget() {
    return Obx(() {
      final String title = 'tree_description_title'.tr;
      final bool isEnabled = controller.description.value.isNotEmpty;
      return _detailWidget(title, isEnabled, () {
        controller.addDescription();
      });
    });
  }

  Widget _addTreeCircumferenceWidget() {
    return Obx(() {
      final String title = 'add_circumference_title'.tr;
      final bool isEnabled = controller.circumference.value.isNotEmpty;
      return _detailWidget(title, isEnabled, () {
        controller.addCircumference();
      });
    });
  }

  Widget _addTreeConditionWidget() {
    return Obx(() {
      final String title = 'add_tree_condition'.tr;
      final bool isEnabled =
          controller.condition.value?.name?.isNotEmpty ?? false;
      return _detailWidget(title, isEnabled, () {
        controller.addCondition();
      });
    });
  }

  Widget _addTreeLocationWidget() {
    return Obx(() {
      final String title = 'tree_location'.tr;
      final bool isEnabled = controller.locationData.value != null;
      return _detailWidget(title, isEnabled, () {
        controller.addTreeLocation();
      });
    });
  }

  Widget _detailWidget(
      String title, bool isEnabled, GestureTapCallback? onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
      child: GestureDetector(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 49),
          child: Container(
            color: ApplicationColors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimen.marginBig),
              child: Row(
                children: <Widget>[
                  if (controller.hasData()) ...<Widget>{
                    if (isEnabled) ...<Widget>{
                      _enabledCheckmark()
                    } else ...<Widget>{
                      _disabledCheckmark()
                    },
                    const SizedBox(
                      width: Dimen.marginNormal,
                    ),
                  },
                  Text(title, style: ApplicationTextStyles.titleTextStyle),
                  const Spacer(),
                  const Icon(Icons.chevron_right, color: ApplicationColors.gray)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button() {
    return Obx(() {
      final bool isEnabled = controller.hasRequiredData();
      return PrimaryButton(
          title: 'next'.tr, isEnabled: isEnabled, onTap: proceed);
    });
  }

  Widget _enabledCheckmark() {
    return SvgPicture.asset(
      'assets/images/checkmark-enabled.svg',
      height: 32,
      width: 32,
    );
  }

  Widget _disabledCheckmark() {
    return SvgPicture.asset('assets/images/checkmark-disabled.svg',
        height: 32, width: 32);
  }

  Widget _loading() {
    return Obx(() => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                LinearProgressIndicator(
                  value: controller.progress.value,
                  color: ApplicationColors.green,
                  backgroundColor: ApplicationColors.disabledGreen,
                ),
                Text(
                  'saving_tree'.tr,
                  style: ApplicationTextStyles.descriptionTextStyle,
                )
              ],
            ),
          ),
        ));
  }

  void proceed() {
    if (controller.circumference.value.isEmpty) {
      controller.circumference.value = '1';
    }
    if (controller.description.value.isEmpty) {
      controller.description.value = ' ';
    }
    controller.createTree();
  }
}

class NewTreeController extends SessionController with StateMixin<bool> {
  NewTreeController(this.addTreePageController, this.newTreeRequest,
      SessionStorage sessionStorage, PhotosService photosService)
      : super(sessionStorage, photosService);

  AddTreePageController addTreePageController;
  NewTreeRequest newTreeRequest;

  RxString mainPhoto = ''.obs;
  List<String> _photos = <String>[];
  RxList<String> thumbnails = RxList<String>();
  RxDouble progress = 0.0.obs;

  Rxn<DictionaryObject> selectedSpecie = Rxn<DictionaryObject>();
  RxString description = ''.obs;
  RxString circumference = ''.obs;
  Rxn<DictionaryObject> condition = Rxn<DictionaryObject>();
  DictionaryObject? badCondition;
  String? badStateDescription;
  Rxn<LatLng> locationData = Rxn<LatLng>();
  RxBool isConditionProvided = false.obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
    change(null, status: RxStatus.success());
  }

  void initialize() {
    final List<String> allImages = <String>[
      addTreePageController.treePhoto.value?.path ?? '',
      addTreePageController.leafPhoto.value?.path ?? '',
      addTreePageController.barkPhoto.value?.path ?? ''
    ];

    _photos = allImages.where((String element) => element.isNotEmpty).toList();
    focusOnPhoto(_photos.firstOrNull ?? '');
  }

  void focusOnPhoto(String path) {
    mainPhoto.value = path;
    thumbnails.value =
        _photos.where((String element) => element != mainPhoto.value).toList();
  }

  bool hasData() {
    return selectedSpecie.value != null ||
        description.isNotEmpty ||
        circumference.isNotEmpty ||
        locationData.value != null;
  }

  bool hasRequiredData() {
    return selectedSpecie.value != null &&
        locationData.value != null &&
        isConditionProvided.value;
  }

  Future<void> selectSpecies() async {
    selectedSpecie.value = await Get.toNamed(SpeciesSelectionPage.path,
        arguments: <String, DictionaryObject?>{
          'selected': selectedSpecie.value
        }) as DictionaryObject?;
  }

  Future<void> addDescription() async {
    description.value = await Get.toNamed(TreeDescriptionPage.path,
            arguments: description.value) as String? ??
        '';
  }

  Future<void> addCircumference() async {
    circumference.value = await Get.toNamed(AddTreeCircumferencePage.path,
            arguments: circumference.value) as String? ??
        '';
  }

  Future<void> addCondition() async {
    final Map<String, dynamic> arguments = <String, dynamic>{
      'state': condition.value,
      'badState': badCondition,
      'differentComment': badStateDescription
    };

    final Map<String, dynamic>? response =
        await Get.toNamed(AddTreeConditionPage.path, arguments: arguments)
            as Map<String, dynamic>?;

    badCondition = response?['badState'] as DictionaryObject?;
    badStateDescription = response?['differentComment'] as String?;
    condition.value = response?['state'] as DictionaryObject?;
    if (condition.value != null) {
      isConditionProvided.value = true;
    } else {
      isConditionProvided.value = false;
    }
  }

  Future<void> addTreeLocation() async {
    locationData.value =
        await Get.toNamed(MapPage.path, arguments: locationData.value)
            as LatLng?;
  }

  Future<void> createTree() async {
    change(null, status: RxStatus.loading());
    final String? tree = addTreePageController.treePhoto.value?.path;
    final String? leaf = addTreePageController.leafPhoto.value?.path;
    final String? bark = addTreePageController.barkPhoto.value?.path;

    final NewTree newTree = NewTree(
        tree: tree,
        leaf: leaf,
        bark: bark,
        species: selectedSpecie.value?.id,
        description: description.value,
        perimeter: int.tryParse(circumference.value),
        state: condition.value?.id,
        stateDescription: badStateDescription,
        latLon: locationData.value,
        badState: badCondition?.id);

    try {
      await newTreeRequest.createTree(newTree, (int count, int total) {
        if (total > 0) {
          progress.value = count / total;
        }
      });
      await photosService.clearCachedPhotos();
      Get.offAllNamed(MyTreesPage.path);
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.success());
    Get.defaultDialog(
        title: error.title,
        middleText: error.message,
        confirm: PrimaryButton(
            title: 'ok'.tr,
            isEnabled: true,
            onTap: () {
              Get.back();
            }));
  }
}
