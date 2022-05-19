import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../camera/camera_page.dart';
import '../ui/styles.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static const String path = '/start_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje drzewa'),
        titleTextStyle: ApplicationTextStyles.appBarTitleTextStyle,
        backgroundColor: ApplicationColors.background,
        elevation: 0.0,
      ),
      backgroundColor: ApplicationColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
                Icons.yard_outlined,
                color: Colors.green,
                size: 150.0),
            const SizedBox(height: 8.0,),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text('Nie masz jeszcz dodanego żadnego drzewa', style: ApplicationTextStyles.bodyBoldTextStyle),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 43, right: 16),
              child: Text('Dodaj swoje pierwsze drzewo i pomóż nam poprawić stan zieleni Naszego miasta', style: ApplicationTextStyles.bodyTextStyle),
            ),
            const SizedBox(height: 8.0,),
            ConstrainedBox(constraints: const BoxConstraints(minHeight: 41), child: OutlinedButton(onPressed: () => { Get.toNamed(CameraPage.path)},style: GreenOvalButtonStyle(), child: const Text('Dodaj drzewo'))),
          ],
        ),
      ),
    );
  }
}