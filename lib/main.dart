import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about_app/about_app_bind.dart';
import 'about_app/about_app_page.dart';
import 'add_circumference_page/add_circumference_bind.dart';
import 'add_circumference_page/add_circumference_page.dart';
import 'add_tree/add_tree_bind.dart';
import 'add_tree/add_tree_page.dart';
import 'add_tree_condition/add_tree_condition_bind.dart';
import 'add_tree_condition/add_tree_condition_page.dart';
import 'all_trees/all_trees_page.dart';
import 'all_trees/all_trees_page_bind.dart';
import 'ar_congratulations/ar_congratulations_page.dart';
import 'ar_congratulations/ar_congratulations_page_bind.dart';
import 'ar_game/ar_game_page.dart';
import 'ar_game/ar_game_page_bind.dart';
import 'camera/camera_page.dart';
import 'camera/camera_page_bind.dart';
import 'challenges/challenges_bind.dart';
import 'challenges/challenges_page.dart';
import 'email_create_account/email_create_account_page.dart';
import 'email_create_account/email_create_account_page_bind.dart';
import 'email_log_in/email_log_in_page.dart';
import 'email_log_in/email_log_in_page_bind.dart';
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
import 'personal_info/personal_info_bind.dart';
import 'personal_info/personal_info_page.dart';
import 'privacy_policy/privacy_policy_bind.dart';
import 'privacy_policy/privacy_policy_page.dart';
import 'rules/rules_bind.dart';
import 'rules/rules_page.dart';
import 'schools_selection/schools_selection_page.dart';
import 'schools_selection/schools_selection_page_bind.dart';
import 'settings/settings_bind.dart';
import 'settings/settings_page.dart';
import 'species_selection/species_selection_page.dart';
import 'species_selection/species_selection_page_bind.dart';
import 'tree_description/tree_description_bind.dart';
import 'tree_description/tree_description_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
      // locale: Get.deviceLocale,
      // locale: const Locale('pl', 'PL'),
      locale: const Locale('en', 'US'),

      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(),
      getPages: <GetPage<StatelessWidget>>[
        GetPage<LogInPage>(
            name: LogInPage.path,
            page: () => const LogInPage(),
            bindings: <Bindings>[LogInPageBind(), AddTreePageBind()],
            transition: Transition.fade),
        GetPage<MyTreesPage>(
            name: MyTreesPage.path,
            page: () => const MyTreesPage(),
            binding: MyTreesPageBind()),
        GetPage<MyTreeDetailsPage>(
            name: MyTreeDetailsPage.path,
            page: () => const MyTreeDetailsPage(),
            binding: MyTreeDetailsPageBind()),
        GetPage<ChallengesPage>(
            name: ChallengesPage.path,
            page: () => const ChallengesPage(),
            binding: ChallengesPageBind()),
        GetPage<AddTreePage>(
            name: AddTreePage.path,
            page: () => const AddTreePage(),
            binding: AddTreePageBind()),
        GetPage<NewTreePage>(
            name: NewTreePage.path,
            page: () => const NewTreePage(),
            binding: NewTreeBind()),
        GetPage<CameraPage>(
            name: CameraPage.path,
            page: () => const CameraPage(),
            binding: CameraPageBind()),
        GetPage<SpeciesSelectionPage>(
            name: SpeciesSelectionPage.path,
            page: () => const SpeciesSelectionPage(),
            binding: SpeciesSelectionBind()),
        GetPage<TreeDescriptionPage>(
            name: TreeDescriptionPage.path,
            page: () => const TreeDescriptionPage(),
            binding: TreeDescriptionPageBind()),
        GetPage<AddTreeCircumferencePage>(
            name: AddTreeCircumferencePage.path,
            page: () => const AddTreeCircumferencePage(),
            binding: AddCircumferencePageBind()),
        GetPage<AddTreeConditionPage>(
            name: AddTreeConditionPage.path,
            page: () => const AddTreeConditionPage(),
            binding: AddTreeConditionBind()),
        GetPage<MapPage>(
            name: MapPage.path,
            page: () => const MapPage(),
            binding: MapPageBind()),
        GetPage<SettingsPage>(
            name: SettingsPage.path,
            page: () => const SettingsPage(),
            binding: SettingsPageBind()),
        GetPage<PersonalInfoPage>(
            name: PersonalInfoPage.path,
            page: () => const PersonalInfoPage(),
            binding: PersonalInfoPageBind()),
        GetPage<SchoolsSelectionPage>(
            name: SchoolsSelectionPage.path,
            page: () => const SchoolsSelectionPage(),
            binding: SchoolsSelectionBind()),
        GetPage<AboutAppPage>(
            name: AboutAppPage.path,
            page: () => const AboutAppPage(),
            binding: AboutAppBind()),
        GetPage<PrivacyPolicyPage>(
            name: PrivacyPolicyPage.path,
            page: () => const PrivacyPolicyPage(),
            binding: PrivacyPolicyBind()),
        GetPage<RulesPage>(
            name: RulesPage.path,
            page: () => const RulesPage(),
            binding: RulesBind()),
        GetPage<EmailLogInPage>(
            name: EmailLogInPage.path,
            page: () => const EmailLogInPage(),
            binding: EmailLogInPageBind()),
        GetPage<EmailCreateAccountPage>(
            name: EmailCreateAccountPage.path,
            page: () => const EmailCreateAccountPage(),
            binding: EmailCreateAccountPageBind()),
        GetPage<AllTreesPage>(
            name: AllTreesPage.path,
            page: () => const AllTreesPage(),
            binding: AllTreesPageBind()),
        GetPage<ArGamePage>(
            name: ArGamePage.path,
            page: () => const ArGamePage(),
            binding: ArGamePageBind()),
        GetPage<ArCongratulationsPage>(
            name: ArCongratulationsPage.path,
            page: () => const ArCongratulationsPage(),
            binding: ArCongratulationsPageBind()),
      ],
      initialRoute: LogInPage.path,
      initialBinding: LogInPageBind(),
    );
  }
}
