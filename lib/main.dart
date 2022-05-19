import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_tree/add_tree_page.dart';
import 'camera/camera_page.dart';
import 'camera/camera_page_binding.dart';
import 'challenges/challenges_page.dart';
import 'landing/landing_page.dart';
import 'landing/landing_page_binding.dart';
import 'start/start_page.dart';
import 'ui/styles.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.green,
        backgroundColor: ApplicationColors.background
      ),
      getPages: [
        GetPage(name: LandingPage.path, page: () => LandingPage(), binding: LandingPageBind()),
        GetPage(name: StartPage.path, page: () => const StartPage()),
        GetPage(name: ChallengesPage.path, page: () => const ChallengesPage()),
        GetPage(name: AddTreePage.path, page: () => const AddTreePage()),
        GetPage(name: CameraPage.path, page: () => const CameraPage(), binding: CameraPageBind())
      ],
      initialRoute: LandingPage.path,
    );
  }
}
