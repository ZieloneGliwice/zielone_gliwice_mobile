import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  static const String path = '/start_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje drzewa'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(
                Icons.yard_outlined,
                color: Colors.green,
                size: 150.0),
            SizedBox(height: 8.0,),
            Text('Nie masz jeszcze dodanych drzew')

          ],
        ),
      ),
    );
  }
}