import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tubes_pbp_6/view/Profile/camera.dart';
import 'package:tubes_pbp_6/client/ProfileClient.dart';
import 'package:tubes_pbp_6/entity/profile.dart';
import 'package:tubes_pbp_6/view/Profile/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _profile_picture;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  Profile? _profileData;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Load profile data from API
  Future<void> _loadProfileData() async {
    try {
      final response = await ProfileClient.getProfile();
      if (response.statusCode == 200) {
        final profileData = Profile.fromJson(jsonDecode(response.body));

        if (mounted) {
          setState(() {
            _profileData = profileData;
            _firstNameController.text = profileData.nama_depan ?? '';
            _lastNameController.text = profileData.nama_belakang ?? '';
            _emailController.text = profileData.email ?? '';
            _phoneController.text = profileData.nomor_telepon ?? '';
            _passwordController.text = profileData.password ?? '';
            _dateOfBirthController.text = profileData.tanggal_lahir ?? '';
            _heightController.text = profileData.height?.toString() ?? '';
            _weightController.text = profileData.weight?.toString() ?? '';
            _genderController.text = profileData.jenis_kelamin ?? '';
            _profile_picture = profileData.profile_picture;
          });
        }
      } else {
        throw Exception("Failed to fetch profile data");
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  Future<void> _saveProfileData() async {
    if (_profileData != null) {
      final updatedProfile = Profile(
        nama_depan: _firstNameController.text,
        nama_belakang: _lastNameController.text,
        email: _emailController.text,
        nomor_telepon: _phoneController.text,
        password: _passwordController.text,
        tanggal_lahir: _dateOfBirthController.text,
        height: int.parse(_heightController.text),
        weight: int.parse(_weightController.text),
        jenis_kelamin: _genderController.text,
        profile_picture:
            _profile_picture, // Pastikan ini terisi dengan path gambar baru
      );

      try {
        final response = await ProfileClient.update(profile: updatedProfile);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Profile updated successfully!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfilePage()), // Mengarah ke halaman profil setelah update
          );
        } else {
          throw Exception("Failed to update profile");
        }
      } catch (e) {
        print("Error saving profile data: $e");
      }
    }
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
                    _profile_picture = imagePath; // Menyimpan path gambar
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(
                    ImageSource.gallery); // Pilih gambar dari galeri
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
        _profile_picture = image.path; // Menyimpan path gambar
      });
    }
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
                        backgroundImage: _profile_picture != null
                            ? FileImage(File(
                                _profile_picture!)) // Menampilkan gambar baru
                            : AssetImage('images/download.jpg')
                                as ImageProvider, // Gambar default jika tidak ada gambar
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
                  _buildTextField('First Name', _firstNameController,
                      icon: Icons.person),
                  _buildTextField('Last Name', _lastNameController,
                      icon: Icons.person),
                  _buildTextField('Email', _emailController, icon: Icons.email),
                  _buildTextField('Phone Number', _phoneController,
                      icon: Icons.phone),
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
