import 'dart:io';

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
import '../ui/error_view.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class SpeciesSelectionPage extends GetView<SpeciesSelectionController> {
  const SpeciesSelectionPage({super.key});

  static const String path = '/species_selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GrayAppBar(
          title: Text('enter_the_tree_species'.tr),
        ),
        backgroundColor: ApplicationColors.white,
        body: controller.obx(
          (bool? state) {
            Analytics.visitedScreen(SpeciesSelectionPage.path);
            return SafeArea(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      style: ApplicationTextStyles.searchTextStyle,
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        filled: true,
                        fillColor: ApplicationColors.inputBackground,
                        hintText: 'search'.tr,
                        prefixIcon: const Icon(Icons.search, color: ApplicationColors.gray, size: 24,),
                        focusedBorder: _searchBorder(),
                        enabledBorder: _searchBorder(),
                        border: _searchBorder(),
                        errorBorder: _searchBorder(),
                        hintStyle: ApplicationTextStyles.searchHintTextStyle
                      ),
                    ),
                  ),

                  Expanded(
                    child: Obx(() => ListView.separated(
                        itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                              controller.selectItem(controller.filteredSpecies[index].id);
                          },
                          child: ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 50),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.filteredSpecies[index].name
                                          ?.capitalize ??
                                          '',
                                      style: controller.filteredSpecies[index].id == controller.selectedSpecie.value?.id ? ApplicationTextStyles.bodyBoldTextStyle :
                                      ApplicationTextStyles.titleTextStyle,
                                      textAlign: TextAlign.start,
                                    )),
                              )),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                        itemCount: controller.filteredSpecies.length),
              )
                  ),
                  _button()
                ],
              ),
            );
          },
          onLoading: const ActivityIndicator(),
          onError: (String? error) => _errorView(error),
        ));
  }

  OutlineInputBorder _searchBorder() {
    return OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.0));
  }

  Widget _button() {
    final bool isEnabled = controller.selectedSpecie.value != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: PrimaryButton(title: 'select'.tr, isEnabled: isEnabled, onTap: controller.save)
      );
  }

  Widget _errorView(String? error) {
    Analytics.visitedErrorScreen(SpeciesSelectionPage.path);
    final ZGError zgError = ZGError.from(error);

    return ErrorView.from(zgError, controller.fetchSpecies);
  }
}

class SpeciesSelectionController extends SessionController with StateMixin<bool> {
  SpeciesSelectionController(this._speciesProvider, this.searchController, SessionStorage sessionStorage, PhotosService photosService) : super(sessionStorage, photosService);

  RxList<DictionaryObject> filteredSpecies = RxList<DictionaryObject>();
  List<DictionaryObject> _allSpecies = <DictionaryObject>[];
  Rxn<DictionaryObject> selectedSpecie = Rxn<DictionaryObject>();

  final DictionaryDataProvider _speciesProvider;
  final TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    final Map<String, DictionaryObject?> arguments = Get.arguments as Map<String, DictionaryObject?>;
    selectedSpecie.value = arguments['selected'];
    fetchSpecies();
    searchController.addListener(() {
        _filterSpieces(searchController.text);
    });
  }

  Future<void> fetchSpecies() async {
    change(false, status: RxStatus.loading());

    try {
      final List<DictionaryObject> result = await _speciesProvider.getData(API.species);
      _allSpecies = result;
      filteredSpecies.value = _allSpecies;
      change(true, status: RxStatus.success());
    } on UnauthorizedException catch (_) {
      unauthorized();
    } on NoInternetConnectionException catch (_) {
      handleError(ConnectionError());
    } catch (_) {
      handleError(CommonError());
    }
  }

  void _filterSpieces(String name) {
    filteredSpecies.value = _allSpecies.where((DictionaryObject element) => element.name?.contains(name) ?? false).toList();
  }

  void selectItem(String? id) {
    selectedSpecie.value = _allSpecies.firstWhereOrNull((DictionaryObject element) => id == element.id);
    change(true, status: RxStatus.success());
  }

  void save() {
    Analytics.buttonPressed('Save');
    Analytics.logEvent('${SpeciesSelectionPage.path}: Save selected specie', parameters: <String, String>{'vale': selectedSpecie.value?.name ?? ''});
    Get.back(result: selectedSpecie.value);
  }

  void handleError(ZGError error) {
    change(null, status: RxStatus.error(error.identifier));
  }
}
