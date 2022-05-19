import 'package:flutter/material.dart';
import 'package:zielone_gliwice_mobile/ui/styles.dart';

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({super.key});

  static const String path = '/challenges_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wyzwania'),
        titleTextStyle: ApplicationTextStyles.appBarTitleTextStyle,
        backgroundColor: ApplicationColors.background,
        elevation: 0.0,
      ),
      backgroundColor: ApplicationColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
                Icons.workspace_premium,
                color: Colors.green,
                size: 150.0),
            SizedBox(height: 8.0,),
            Text('Nie masz jeszcze wyzwań')
          ],
        ),
      ),
    );
  }
}