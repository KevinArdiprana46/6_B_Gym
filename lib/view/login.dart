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
        decoration: const BoxDecoration(
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
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* Tombol Login
                  ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        //* Jika sudah valid, cek username dan password pada form sudah sesuai dengan data
                        //* yang dibawah dari halaman register atau belum
                        if(dataForm!['username'] == usernameController.text && dataForm['password'] == passwordController.text )
                        {
                          //* Jika sesuai navigasi ke halaman Home
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BerandaView()));
                        }
                        else{
                          //* Jika belum tampilkan Alert Dialog
                          showDialog(context: context, builder: (_)=>AlertDialog(
                            title: const Text('Password Salah'),
                            content: TextButton(
                              onPressed: () =>pushRegister(context),
                              child: const Text('Daftar Disini !!')),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                                ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                                ),
                            ],
                          ),);
                        }
                      }
                    },
                    child: const Text('Login')),
                    //* Tombol ke halaman register
                    TextButton(
                      onPressed: () {
                        Map<String, dynamic> formData = {};
                        formData['username'] = usernameController.text;
                        formData['password'] = passwordController.text;
                        pushRegister(context);
                      },
                      child: const Text('Belum punya akun ?')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void pushRegister(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (_) => const RegisterView(),),);
  }
}