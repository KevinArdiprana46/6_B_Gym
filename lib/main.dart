import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/login_register/prelogin.dart';



void main() {
  runApp(MaterialApp(
    home: PreLoginView(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: PreLoginView(),

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
