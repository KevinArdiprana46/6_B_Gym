import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/camera.dart';
import 'package:tubes_pbp_6/view/view_list.dart';
import 'package:tubes_pbp_6/view/home.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _profileImagePath;
  int _selectedIndex = 4;

  void _onItemTapped(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BerandaView(initialIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Color(0xFF5565E8),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: _profileImagePath != null
                              ? FileImage(File(_profileImagePath!))
                              : const AssetImage('images/download.jpg')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 18,
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Color(0xFF5565E8)),
                              onPressed: () async {
                                final imagePath = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CameraView(),
                                  ),
                                );
                                if (imagePath != null) {
                                  setState(() {
                                    _profileImagePath = imagePath;
                                  });
                                }
                              },
                              iconSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildTextField('Username', initialValue: 'Fahmy'),
                    const SizedBox(height: 16),
                    _buildTextField('No Telephone',
                        initialValue: '+62xxxxxxxxx', icon: Icons.phone),
                    const SizedBox(height: 16),
                    _buildTextField('Email',
                        initialValue: 'fahmy8394@gmail.com', icon: Icons.email),
                    const SizedBox(height: 16),
                    _buildTextField('Password',
                        initialValue: '*******',
                        icon: Icons.lock,
                        obscureText: true),
                    const SizedBox(height: 16),
                    _buildTextField('Date of Birth',
                        initialValue: '1988/01/21', icon: Icons.calendar_today),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField('Height',
                              initialValue: '200 CM', icon: Icons.height),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField('Weight',
                              initialValue: '75 KG',
                              icon: Icons.monitor_weight),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField('Gender',
                        initialValue: 'Male', icon: Icons.person),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Kembali ke halaman profile
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BerandaView(initialIndex: 4),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5565E8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.white,
          backgroundColor: Color(0xFF5565E8),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Review',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            _onItemTapped(index);
          },
        ),
      ),
    );
  }

  // Helper method for creating Text Fields
  Widget _buildTextField(String label,
      {String? initialValue, IconData? icon, bool obscureText = false}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon, color: Color(0xFF5565E8)) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      controller: TextEditingController(text: initialValue),
    );
  }
}
