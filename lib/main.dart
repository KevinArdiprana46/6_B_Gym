import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/helper/shared_preference.helper.entity.dart';
import 'package:tubes_pbp_6/view/home.dart';
import 'package:tubes_pbp_6/view/login_register/prelogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  runApp(MaterialApp(
    home: PreLoginView(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BerandaView(),
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
