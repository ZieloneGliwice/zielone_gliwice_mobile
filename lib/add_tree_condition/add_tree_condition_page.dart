import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../analytics/analytics.dart';
import '../api.dart';
import '../model/dictionary_object.dart';
import '../model/errors.dart';
import '../network/api_dio.dart';
import '../network/dictionary_data_provider.dart';
import '../services/photos_service.dart';
import '../ui/activity_indicator.dart';
import '../ui/dimen.dart';
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class AddTreeConditionPage extends GetView<AddTreeConditionPageController> {
  const AddTreeConditionPage({super.key});

  static const String path = '/add_tree_condition';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('add_tree_condition'.tr),
      ),
      backgroundColor: ApplicationColors.white,
      body:
          controller.obx((_) => _body(),
              onLoading: const ActivityIndicator(),
            onError: (String? error) => _errorView(error),
          ),
    );
  }

  Widget _body() {
    Analytics.visitedScreen(AddTreeConditionPage.path);
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                child: Obx(
                  () => Column(
                    children: <Widget>[
                      Text(
                        'add_tree_condition_description'.tr,
                        style: ApplicationTextStyles.descriptionTextStyle,
                      ),
                      const SizedBox(
                        height: Dimen.marginSmall,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: ApplicationColors.green,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              for (int i = 0;
                                  i < controller.treeStates.length;
                                  i++) ...<Widget>[
                                _selectedButton(
                                    controller.treeStates[i].name?.capitalize ??
                                        '',
                                    controller.selectedState.value == i, () {
                                  controller.select(i);
                                  Analytics.buttonPressed(controller.treeStates[i].name?.capitalize ??
                                      '');
                                  Analytics.logEvent('${AddTreeConditionPage.path}: Condition changed');
                                })
                              ]
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: Dimen.marginSmall,
                      ),
                      if (controller.selectedBadState != null) ...<Widget>{
                        if (controller.isDifferentCondition()) ...<Widget>{
                          Text('add_tree_condition_input_title'.tr,
                              style: ApplicationTextStyles
                                  .descriptionBoldTextStyle),
                          Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: controller._textEditingController,
                              decoration: InputDecoration(
                                  hintText: 'tree_description_hint'.tr,
                                  hintStyle:
                                      ApplicationTextStyles.hintTextStyle,
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
                        } else ...<Widget>{
                          const SizedBox(
                            height: Dimen.marginNormal,
                          ),
                          Text(
                              controller.selectedBadState.value?.name
                                      ?.capitalize ??
                                  '',
                              style: ApplicationTextStyles
                                  .descriptionBoldTextStyle),
                        }
                      },
                      const SizedBox(
                        height: Dimen.marginSmall,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: PrimaryButton(
                            title: 'save'.tr,
                            isEnabled: true,
                            onTap: controller.save),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _selectedButton(String title, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ApplicationColors.white : ApplicationColors.green,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: Dimen.buttonHeight),
            child: InkWell(
                onTap: onTap,
                child: Center(
                    child: Text(
                  title,
                  style: isSelected
                      ? ApplicationTextStyles.toggleSelectedLabelStyle
                      : ApplicationTextStyles.toggleDeselectedLabelStyle,
                )))),
      ),
    );
  }

  UnderlineInputBorder _underlineDecorator() {
    return const UnderlineInputBorder(
        borderSide: BorderSide(color: ApplicationColors.silver, width: 0.4));
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(AddTreeConditionPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.fetchData);
  }
}

class AddTreeConditionPageController extends SessionController
    with StateMixin<bool> {
  AddTreeConditionPageController(
      this._dictionaryDataProvider, this._textEditingController, SessionStorage sessionStorage, PhotosService photosService) : super(sessionStorage, photosService);

  final DictionaryDataProvider _dictionaryDataProvider;
  final TextEditingController _textEditingController;

  RxList<DictionaryObject> treeStates = RxList<DictionaryObject>();
  RxList<DictionaryObject> treeBadStates = RxList<DictionaryObject>();
  RxInt selectedState = 0.obs;
  Rxn<DictionaryObject> selectedBadState = Rxn<DictionaryObject>();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    change(null, status: RxStatus.loading());

    try {
      treeStates.value = await _dictionaryDataProvider.getData(API.state);
      treeBadStates.value = await _dictionaryDataProvider.getData(API.badState);

      if (treeStates.isNotEmpty) {
        _restore();
        change(true, status: RxStatus.success());
      } else {
        handleError(CommonError());
      }
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void _restore() {
    final Map<String, dynamic> arguments =
        Get.arguments as Map<String, dynamic>;

    final DictionaryObject? state = arguments['state'] as DictionaryObject?;
    final int stateIndex = treeStates.indexWhere((DictionaryObject element) =>
        element.id == state?.id && element.name == state?.name);

    selectedState.value = stateIndex != -1 ? stateIndex : 0;

    final DictionaryObject? badState =
        arguments['badState'] as DictionaryObject?;
    final int badStateIndex = treeBadStates.indexWhere(
        (DictionaryObject element) =>
            element.id == badState?.id && element.name == badState?.name);

    selectedBadState.value =
        badStateIndex != -1 ? treeBadStates[badStateIndex] : null;

    final String differentComment =
        arguments['differentComment'] as String? ?? '';
    _textEditingController.text =
        selectedBadState.value != null ? differentComment : '';
  }

  void select(int index) {
    selectedState.value = index;
    if (index == 1) {
      showBadState();
    } else {
      selectedBadState.value = null;
      _textEditingController.text = '';
    }
  }

  bool isDifferentCondition() {
    return selectedBadState.value != null &&
        selectedBadState.value == treeBadStates.lastOrNull;
  }

  Future<void> showBadState() async {
    final DictionaryObject? result = await Get.bottomSheet(
        Container(
          color: ApplicationColors.background,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 49),
                    child: Container(
                        color: ApplicationColors.white,
                        child: Center(
                            child: Text(
                          'add_tree_condition_observation_title'.tr,
                          style:
                              ApplicationTextStyles.bottomSheetTitleTextStyle,
                          textAlign: TextAlign.center,
                        )))),
              ),
              for (int i = 0; i < treeBadStates.length; i++) ...<Widget>[
                _sheetElement(treeBadStates[i].name?.capitalize ?? '', () {
                  Get.back(result: treeBadStates[i]);
                })
              ],
              _sheetElement('cancel'.tr, () {
                Get.back();
              }, textStyle: ApplicationTextStyles.bottomSheetCancelTextStyle)
            ],
          ),
        ),
        isDismissible: true,
        ignoreSafeArea: false,
        isScrollControlled: true);

    if (result != null) {
      selectedBadState.value = result;

      if (!isDifferentCondition()) {
        _textEditingController.text = '';
      }
    } else if (selectedBadState.value == null) {
      // Return to health state
      selectedState.value = 0;
      _textEditingController.text = '';
    }
  }

  Widget _sheetElement(String title, VoidCallback onTap,
      {TextStyle textStyle = ApplicationTextStyles.bottomSheetTextStyle}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 1),
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: ApplicationColors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConstrainedBox(
                constraints: const BoxConstraints(
                    minHeight: 40, minWidth: double.infinity),
                child: Center(
                    child: Text(
                  title,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ))),
          ),
        ),
      ),
    );
  }

  void save() {
    Analytics.buttonPressed('Save');
    Analytics.logEvent('${AddTreeConditionPage.path}: Save condition');

    final DictionaryObject state = treeStates[selectedState.value];
    final String? comment = _textEditingController.text.isNotEmpty == true
        ? _textEditingController.text
        : null;
    Get.back(result: <String, dynamic>{
      'state': state,
      'badState': selectedBadState.value,
      'differentComment': comment
    });
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
