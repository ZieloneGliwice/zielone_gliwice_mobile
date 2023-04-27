import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_circumference_page/add_circumference_bind.dart';
import 'add_circumference_page/add_circumference_page.dart';
import 'add_tree/add_tree_bind.dart';
import 'add_tree/add_tree_page.dart';
import 'add_tree_condition/add_tree_condition_bind.dart';
import 'add_tree_condition/add_tree_condition_page.dart';
import 'camera/camera_page.dart';
import 'camera/camera_page_bind.dart';
import 'challenges/challenges_page.dart';
import 'internationalization/translations.dart';
import 'log_in/log_in_page.dart';
import 'log_in/log_in_page_bind.dart';
import 'map/map_page.dart';
import 'map/map_page_bind.dart';
import 'my_tree_details/my_tree_details_page.dart';
import 'my_tree_details/my_tree_details_page_bind.dart';
import 'my_trees/my_trees_page.dart';
import 'my_trees/my_trees_page_bind.dart';
import 'new_tree/new_tree_bind.dart';
import 'new_tree/new_tree_page.dart';
import 'species_selection/species_selection_page.dart';
import 'species_selection/species_selection_page_bind.dart';
import 'tree_description/tree_description_bind.dart';
import 'tree_description/tree_description_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zielone Gliwice',
      translations: ApplicationTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(),
      getPages: <GetPage<StatelessWidget>>[
        GetPage<LogInPage>(name: LogInPage.path, page: () => const LogInPage(), bindings: <Bindings>[LogInPageBind(), AddTreePageBind()], transition: Transition.fade),
        GetPage<MyTreesPage>(name: MyTreesPage.path, page: () => const MyTreesPage(), binding: MyTreesPageBind()),
        GetPage<MyTreeDetailsPage>(name: MyTreeDetailsPage.path, page: () => const MyTreeDetailsPage(), binding: MyTreeDetailsPageBind()),
        GetPage<ChallengesPage>(name: ChallengesPage.path, page: () => const ChallengesPage()),
        GetPage<AddTreePage>(name: AddTreePage.path, page: () => const AddTreePage(), binding: AddTreePageBind()),
        GetPage<NewTreePage>(name: NewTreePage.path, page: () => const NewTreePage(), binding: NewTreeBind()),
        GetPage<CameraPage>(name: CameraPage.path, page: () => const CameraPage(), binding: CameraPageBind()),
        GetPage<SpeciesSelectionPage>(name: SpeciesSelectionPage.path, page: () => const SpeciesSelectionPage(), binding: SpeciesSelectionBind()),
        GetPage<TreeDescriptionPage>(name: TreeDescriptionPage.path, page: () => const TreeDescriptionPage(), binding: TreeDescriptionPageBind()),
        GetPage<AddTreeCircumferencePage>(name: AddTreeCircumferencePage.path, page: () => const AddTreeCircumferencePage(), binding: AddCircumferencePageBind()),
        GetPage<AddTreeConditionPage>(name: AddTreeConditionPage.path, page: () => const AddTreeConditionPage(), binding: AddTreeConditionBind()),
        GetPage<MapPage>(name: MapPage.path, page: () => const MapPage(), binding: MapPageBind()),
      ],
      initialRoute: LogInPage.path,
      initialBinding: LogInPageBind(),
    );
  }
}
