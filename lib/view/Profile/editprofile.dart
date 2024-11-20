import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_pbp_6/view/Profile/camera.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _profileImagePath;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  int _selectedIndex = 4; // Default to profile tab

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? 'Fahmy';
      _phoneController.text = prefs.getString('phone') ?? '+62xxxxxxxxx';
      _emailController.text = prefs.getString('email') ?? 'fahmy8394@gmail.com';
      _passwordController.text = prefs.getString('password') ?? '*******';
      _dateOfBirthController.text =
          prefs.getString('dateOfBirth') ?? '1988/01/21';
      _heightController.text = prefs.getString('height') ?? '200 CM';
      _weightController.text = prefs.getString('weight') ?? '75 KG';
      _genderController.text = prefs.getString('gender') ?? 'Male';
      _profileImagePath = prefs.getString('profileImagePath');
    });
  }

  Future<void> _saveProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('password', _passwordController.text);
    await prefs.setString('dateOfBirth', _dateOfBirthController.text);
    await prefs.setString('height', _heightController.text);
    await prefs.setString('weight', _weightController.text);
    await prefs.setString('gender', _genderController.text);
    if (_profileImagePath != null) {
      await prefs.setString('profileImagePath', _profileImagePath!);
    }
    Navigator.pop(context);
  }

  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final imagePath = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CameraView()),
                );
                if (imagePath != null) {
                  setState(() {
                    _profileImagePath = imagePath;
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _profileImagePath = image.path;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic based on the selected index, e.g.,
    // navigate to different pages depending on the index.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF5565E8),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: _profileImagePath != null
                            ? FileImage(File(_profileImagePath!))
                            : AssetImage('images/download.jpg')
                                as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt,
                                color: Color(0xFF5565E8)),
                            onPressed: _showImageSourceActionSheet,
                            iconSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  _buildTextField('Username', _usernameController,
                      icon: Icons.person),
                  _buildTextField('No Telephone', _phoneController,
                      icon: Icons.phone),
                  _buildTextField('Email', _emailController, icon: Icons.email),
                  _buildTextField('Password', _passwordController,
                      obscureText: true, icon: Icons.lock),
                  _buildTextField('Date of Birth', _dateOfBirthController,
                      icon: Icons.calendar_today),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField('Height', _heightController,
                            icon: Icons.height),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField('Weight', _weightController,
                            icon: Icons.monitor_weight),
                      ),
                    ],
                  ),
                  _buildTextField('Gender', _genderController,
                      icon: Icons.person),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfileData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF5565E8),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {IconData? icon, bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              icon != null ? Icon(icon, color: Color(0xFF5565E8)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }
}
