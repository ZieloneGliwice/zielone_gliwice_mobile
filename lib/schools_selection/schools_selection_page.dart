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
              padding: const EdgeInsets.only(top: 10, bottom: 50),
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
    'Szkoła Podstawowa z Oddziałami Integracyjnymi nr 1 w Gliwicach w Zespole Szkolno-Przedszkolnym nr 5 w Gliwicach',
    'Szkoła Podstawowa nr 2 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Integracyjnymi nr 3 im. Arka Bożka w Gliwicach',
    'Szkoła Podstawowa nr 4 w Gliwicach w Zespole Szkół Ogólnokształcących nr 4 im. Piastów Śląskich w Gliwicach',
    'Szkoła Podstawowa nr 5 w Gliwicach w Zespole Szkolno-Przedszkolnym nr 3 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Dwujęzycznymi nr 6 im. Noblistów Polskich w Gliwicach w Zespole Szkół i Placówek Oświatowych nr 1 w Gliwicach',
    'Szkoła Podstawowa nr 7 im. Adama Mickiewicza w Gliwicach w Zespole Szkolno-Przedszkolnym nr 11 w Gliwicach',
    'Szkoła Podstawowa nr 8 im. Marii Dąbrowskiej w Gliwicach',
    'Szkoła Podstawowa nr 9 im. Króla Jana III Sobieskiego w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Integracyjnymi nr 10 im. Juliusza Słowackiego w Gliwicach w Zespole Szkolno-Przedszkolnym nr 7 w Gliwicach',
    'Szkoła Podstawowa nr 11 im. Hugona Kołłątaja w Gliwicach',
    'Szkoła Podstawowa nr 12 im. Mikołaja Kopernika w Gliwicach w Zespole Szkolno-Przedszkolnym nr 2 w Gliwicach',
    'Szkoła Podstawowa nr 13 im. Krystyny Bochenek w Gliwicach',
    'Szkoła Podstawowa nr 14 im. Stefana Żeromskiego w Gliwicach w Zespole Szkół Ogólnokształcących nr 14 w Gliwicach',
    'Szkoła Podstawowa nr 15 im. Ignacego Jana Paderewskiego w Gliwicach w Zespole Szkolno-Przedszkolnym nr 12 w Gliwicach',
    'Szkoła Podstawowa nr 16 w Gliwicach w Zespole Szkolno-Przedszkolnym nr 1 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Dwujęzycznymi nr 17 w Gliwicach w Zespole Szkolno-Przedszkolnym nr 17 w Gliwicach',
    'Szkoła Podstawowa nr 18 im. Jana Pawła II w Gliwicach w Zespole Szkolno-Przedszkolnym nr 8 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Sportowymi nr 19 w Gliwicach w Zespole Szkół Ogólnokształcących nr 8 w Gliwicach',
    'Szkoła Podstawowa nr 20 im. Powstańców Śląskich w Gliwicach w Zespole Szkolno-Przedszkolnym nr 10 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Integracyjnymi nr 21 im. Henryka Sienkiewicza w Gliwicach',
    'Szkoła Podstawowa Specjalna nr 22 w Gliwicach w Zespole Szkół Specjalnych im. Janusza Korczaka w Gliwicach',
    'Szkoła Podstawowa nr 23 im. Tadeusza Różewicza w Gliwicach w Zespole Szkolno-Przedszkolnym nr 16 w Gliwicach',
    'Szkoła Podstawowa Specjalna nr 25 im. Józefy Joteyko w Gliwicach w Zespole Szkół Ogólnokształcących Specjalnych nr 7 w Gliwicach',
    'Szkoła Podstawowa Specjalna nr 26 w Gliwicach w Młodzieżowym Ośrodku Socjoterapii w Gliwicach',
    'Szkoła Podstawowa nr 27 w Gliwicach w Zespole Szkolno-Przedszkolnym nr 13 w Gliwicach',
    'Szkoła Podstawowa nr 28 im. Witolda Budryka w Gliwicach w Zespole Szkolno-Przedszkolnym nr 14 w Gliwicach',
    'Szkoła Podstawowa nr 30 w Gliwicach w Zespole Szkół Ogólnokształcących nr 5 im. Armii Krajowej w Gliwicach',
    'Szkoła Podstawowa nr 32 im. Wojska Polskiego w Gliwicach w Zespole Szkolno-Przedszkolnym nr 9 w Gliwicach',
    'Szkoła Podstawowa nr 36 im. Johna Baildona w Gliwicach w Zespole Szkolno-Przedszkolnym nr 6 w Gliwicach',
    'Szkoła Podstawowa nr 38 w Gliwicach w Zespole Szkół Ogólnokształcących nr 2 w Gliwicach',
    'Szkoła Podstawowa z Oddziałami Integracyjnymi nr 39 im. Obrońców Pokoju w Gliwicach w Zespole Szkolno-Przedszkolnym nr 4 w Gliwicach',
    'Szkoła Podstawowa nr 41 im. Władysława Broniewskiego w Gliwicach w Zespole Szkolno-Przedszkolnym nr 15 w Gliwicach',
    'Szkoła Podstawowa dla Dorosłych nr 50 w Gliwicach w Górnośląskim Centrum Edukacyjnym im. Marii Skłodowskiej-Curie w Gliwicach',
    'Technikum nr 1 w Zespole Szkół Techniczno-Informatycznych',
    'Technikum nr 2 w Górnośląskim Centrum Edukacyjnym im. Marii Skłodowskiej-Curie',
    'Technikum nr 3 w Zespole Szkół Łączności',
    'Technikum nr 4 w Zespole Szkół Budowlano-Ceramicznych',
    'Technikum nr 5 i Technikum nr 6 w Centrum Kształcenia Zawodowego i Ustawicznego nr 1',
    'Technikum nr 7 w Zespole Szkół Samochodowych im. Gen. Stefana Roweckiego "Grota"',
    'Technikum nr 8 im. Cichociemnych w Zespole Szkół Ekonomiczno-Technicznych',
    'I Liceum Ogólnokształcące Dwujęzyczne im. E. Dembowskiego w Gliwicach',
    'II Liceum Ogólnokształcące im. Walerego Wróblewskiego w Gliwicach',
    'III Liceum Ogólnokształcące im. Wincentego Styczyńskiego w Gliwicach w ZSO nr 8',
    'IV Liceum Ogólnokształcące im. Orląt Lwowskich w Gliwicach',
    'V Liceum Ogólnokształcące z Oddziałami Dwujęzycznymi im. Andrzeja Struga w Gliwicach',
    'VII Liceum Ogólnokształcące w Gliwicach w ZSO nr 4 im. Piastów Śląskich w Gliwicach',
    'VIII Liceum Ogólnokształcące z Oddziałami Integracyjnymi w Gliwicach w ZSO nr 5 im. Armii Krajowej',
    'IX Liceum Ogólnokształcące Specjalne w Gliwicach w ZSSp im. Janusz Korczaka',
    'XI Liceum Ogólnokształcące Sportowe w Zespole Szkół Techniczno-Informatycznych',
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
