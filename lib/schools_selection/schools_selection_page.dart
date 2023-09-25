import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../analytics/analytics.dart';
import '../services/photos_service.dart';
import '../ui/gray_app_bar.dart';
import '../ui/primary_button.dart';
import '../ui/styles.dart';
import '../utils/session_controller.dart';
import '../utils/session_storage.dart';

class SchoolsSelectionPage extends GetView<SchoolsSelectionController> {
  const SchoolsSelectionPage({super.key});

  static const String path = '/schools_selection_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GrayAppBar(
        title: Text('choose_school'.tr),
      ),
      backgroundColor: ApplicationColors.white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 10, bottom: 50),
                itemCount: controller.schools.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () => controller.selectedSchool.value = index,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 50),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(
                          () => Text(
                            controller.schools[index].capitalize ?? '',
                            style: index == controller.selectedSchool.value
                                ? ApplicationTextStyles.bodyBoldTextStyle
                                : ApplicationTextStyles.titleTextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
            Obx(() => _button())
          ],
        ),
      ),
    );
  }

  Widget _button() {
    final bool isEnabled = controller.selectedSchool.value != -1;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: PrimaryButton(
            title: 'select'.tr, isEnabled: isEnabled, onTap: controller.save),
      ),
    );
  }
}

class SchoolsSelectionController extends SessionController
    with StateMixin<bool> {
  SchoolsSelectionController(this.searchController,
      SessionStorage sessionStorage, PhotosService photosService)
      : super(sessionStorage, photosService);

  final List<String> schools = <String>[
    'Szkoła1',
    'Szkoła2',
    'Szkoła3',
    'Szkoła4',
    'Szkoła5',
    'Szkoła6',
    'Szkoła7',
    'Szkoła8',
    'Szkoła9',
    'Szkoła10',
    'Szkoła11',
    'Szkoła12',
    'Szkoła13',
    'Szkoła14',
    'Szkoła15',
    'Szkoła16',
    'Szkoła17',
    'Szkoła18',
  ];

  RxInt selectedSchool = (-1).obs;

  final TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    await loadSchool();
  }

  Future<void> loadSchool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String schoolName = prefs.getString('school') ?? '';
    if (schoolName != '') {
      selectedSchool.value = schools.indexOf(schoolName);
    } else {
      selectedSchool.value = -1;
    }
  }

  Future<void> save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('school', schools[selectedSchool.value]);
    Analytics.updateUserSchool(schools[selectedSchool.value]);
    Get.back(result: schools[selectedSchool.value]);
  }
}
