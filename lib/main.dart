import 'package:flutter/material.dart';

import 'package:tubes_pbp_6/view/login.dart';

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

      home: LoginView(),

    );
  }
}


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
