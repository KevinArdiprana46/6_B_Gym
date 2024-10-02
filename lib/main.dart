import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/profile.dart';

void main() {
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hai');

        ),
      ),
    );
  }
}
