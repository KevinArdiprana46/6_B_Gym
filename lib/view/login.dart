import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/View/home.dart';
import 'package:tubes_pbp_6/View/register.dart';
import 'package:tubes_pbp_6/component/form_component.dart';

class LoginView extends StatefulWidget {
  final Map? data;

  const LoginView({super.key, this.data});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    
    Map? dataForm = widget.data;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://st4.depositphotos.com/18672748/21457/v/450/depositphotos_214578124-stock-illustration-gym-icon-vector-isolated-white.jpg'),
            fit: BoxFit.fill,
            ),
          ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                
              //* Username
              inputForm((p0){
                if(p0 == null || p0.isEmpty){
                  return "username tidak boleh kosong";
                }
                return null;
              },
                  controller: usernameController,
                  hintTxt: "Username",
                  helperTxt: "Inputkan User yang telah didaftar",
                  iconData: Icons.person),
              //* Password
              inputForm((p0){
                if(p0 == null || p0.isEmpty){
                  return "password kosong";
                }
                return null;
              },
                  password: true,
                  controller: passwordController,
                  hintTxt: "Password",
                  helperTxt: "Inputkan Password",
                  iconData: Icons.password),
            ],
          ),
        ),
      ),
    );
  }
  // void pushRegister(BuildContext context){
  //   Navigator.push(context,MaterialPageRoute(builder: (_) => const RegisterView(),),);
  // }
}