import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'camera/camera_page.dart';
import 'camera/camera_page_binding.dart';

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
      ),
      getPages: [
        GetPage(name: MyHomePage.path, page: () => const MyHomePage()),
        GetPage(name: CameraPage.path, page: () => const CameraPage(), binding: CameraPageBind())
      ],
      initialRoute: MyHomePage.path,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String path = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zielone Gliwice'),
      ),
      body: Center(
        child: OutlinedButton(
            onPressed: () => Get.toNamed(CameraPage.path),
            child: const Text('Dodaj nowe zdjęcie')
        ),
      ),
    );
  }
}
