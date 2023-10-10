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
            ListView.separated(
              padding: const EdgeInsets.only(top: 10, bottom: 60),
              itemCount: controller.schools.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => controller.selectedSchool.value = index,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 50),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Align(
                      child: Obx(
                        () => Text(
                          controller.schools[index],
                          style: index == controller.selectedSchool.value
                              ? ApplicationTextStyles.bodyBoldTextStyle
                              : ApplicationTextStyles.titleTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 2,
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
    'Szkoła Podstawowa nr 1',
    'Szkoła Podstawowa nr 2',
    'Szkoła Podstawowa nr 3',
    'Szkoła Podstawowa nr 4',
    'Szkoła Podstawowa nr 5',
    'Szkoła Podstawowa nr 6',
    'Szkoła Podstawowa nr 7',
    'Szkoła Podstawowa nr 8',
    'Szkoła Podstawowa nr 9',
    'Szkoła Podstawowa nr 10',
    'Szkoła Podstawowa nr 11',
    'Szkoła Podstawowa nr 12',
    'Szkoła Podstawowa nr 13',
    'Szkoła Podstawowa nr 14',
    'Szkoła Podstawowa nr 15',
    'Szkoła Podstawowa nr 16',
    'Szkoła Podstawowa nr 17',
    'Szkoła Podstawowa nr 18',
    'Szkoła Podstawowa nr 19',
    'Szkoła Podstawowa nr 20',
    'Szkoła Podstawowa nr 21',
    'Szkoła Podstawowa nr 22',
    'Szkoła Podstawowa nr 23',
    'Szkoła Podstawowa nr 25',
    'Szkoła Podstawowa nr 26',
    'Szkoła Podstawowa nr 27',
    'Szkoła Podstawowa nr 28',
    'Szkoła Podstawowa nr 30',
    'Szkoła Podstawowa nr 32',
    'Szkoła Podstawowa nr 36',
    'Szkoła Podstawowa nr 38',
    'Szkoła Podstawowa nr 39',
    'Szkoła Podstawowa nr 41',
    'Szkoła Podstawowa nr 50',
    'Zespole Szkół Techniczno-Informatycznych',
    'Technikum nr 5 i Technikum nr 6 w CKZiU nr 1',
    'Technikum nr 2 w GCE',
    'Technikum nr 3 w ZSŁ',
    'Technikum nr 4 w ZSB-C',
    'Technikum nr 7 w ZSS',
    'Technikum nr 8 w ZSE-T',
    'I Liceum Ogólnokształcące',
    'II Liceum Ogólnokształcące',
    'III Liceum Ogólnokształcące',
    'IV Liceum Ogólnokształcące',
    'V Liceum Ogólnokształcące',
    'VII Liceum Ogólnokształcące',
    'VIII Liceum Ogólnokształcące',
    'IX Liceum Ogólnokształcące',
    'XI Liceum Ogólnokształcące',
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
    if (schools[selectedSchool.value].isNotEmpty &&
        schools[selectedSchool.value] != null &&
        schools[selectedSchool.value] != '') {
      Get.back(result: schools[selectedSchool.value]);
    } else {
      Get.back(result: '');
    }
  }
}
