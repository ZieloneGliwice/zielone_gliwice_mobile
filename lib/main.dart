import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_tree/add_tree_page.dart';
import 'bottom_bar/bottom_bar_page.dart';
import 'bottom_bar/bottom_bar_page_bind.dart';
import 'challenges/challenges_page.dart';
import 'internationalization/translations.dart';
import 'my_trees/my_trees_page.dart';

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
      getPages: <GetPage<StatelessWidget>>[
        GetPage<BottomBarPage>(name: BottomBarPage.path, page: () => const BottomBarPage(), binding: BottomBarPageBind()),
        GetPage<MyTreesPage>(name: MyTreesPage.path, page: () => const MyTreesPage()),
        GetPage<ChallengesPage>(name: ChallengesPage.path, page: () => const ChallengesPage()),
        GetPage<AddTreePage>(name: AddTreePage.path, page: () => const AddTreePage()),
      ],
      initialRoute: BottomBarPage.path,
    );
  }
}
