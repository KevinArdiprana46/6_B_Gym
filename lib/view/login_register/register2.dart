import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/login_register/login.dart';
import 'package:tubes_pbp_6/entity/user.dart';
import 'package:tubes_pbp_6/client/UserClient.dart';

class RegisterView2 extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  const RegisterView2({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterView2> createState() => _RegisterViewState2();
}

class _RegisterViewState2 extends State<RegisterView2> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('lib/assets/registerAsset/vektorRegister2.png',
                    height: 200),
                SizedBox(height: 20),
                Text("Let's complete your profile",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                Text("It will help us to know more about you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                SizedBox(height: 20),
                TextFormField(
                  controller: dateOfBirthController,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    prefixIcon: Icon(Icons.calendar_today),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your date of birth';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: weightController,
                  decoration: InputDecoration(
                    hintText: "Your Weight",
                    suffixText: "KG",
                    prefixIcon: Icon(Icons.fitness_center),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: heightController,
                  decoration: InputDecoration(
                    hintText: "Your Height",
                    suffixText: "CM",
                    prefixIcon: Icon(Icons.height),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: telephoneController,
                  decoration: InputDecoration(
                    hintText: "Telephone",
                    prefixIcon: Icon(Icons.phone),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your telephone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text("Male"),
                    Radio<String>(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                    Text("Female"),
                  ],
                ),
                if (gender == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Please select your gender',
                        style: TextStyle(color: Colors.red, fontSize: 12)),
                  ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && gender != null) {
                        final user = User(
                          user_id: 0,
                          nama_depan: widget.firstName,
                          nama_belakang: widget.lastName,
                          password: widget.password,
                          email: widget.email,
                          profile_picture: '',
                          tanggal_lahir: dateOfBirthController.text,
                          jenis_kelamin: gender!,
                          nomor_telepon: telephoneController.text,
                          weight: int.parse(weightController.text),
                          height: int.parse(heightController.text),
                        );
                        UserClient.register(user).then((response) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        }).catchError((error) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Registration Failed'),
                              content: Text('$error'),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5565E8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text('Confirm',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
