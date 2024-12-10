import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tubes_pbp_6/client/profileClient.dart';
import 'package:tubes_pbp_6/entity/profile.dart';
import 'package:tubes_pbp_6/view/Profile/profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? _profilePicture;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  Profile? _profileData;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

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
            _dateOfBirthController.text = profileData.tanggal_lahir ?? '';
            _heightController.text = profileData.height?.toString() ?? '';
            _weightController.text = profileData.weight?.toString() ?? '';
            _profilePicture = profileData.profile_picture;
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
        nomor_telepon: _phoneController.text,
        tanggal_lahir: _dateOfBirthController.text,
        height: int.tryParse(_heightController.text),
        weight: int.tryParse(_weightController.text),
        profile_picture: _profilePicture,
      );

      try {
        final response = await ProfileClient.update(profile: updatedProfile);
        if (response.statusCode == 200) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Profile updated successfully"),
                backgroundColor: Colors.green,
              ),
            );
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        } else {
          print('Failed to update profile: ${response.statusCode}');
          print('Response body: ${response.body}');
          throw Exception("Failed to update profile");
        }
      } catch (e) {
        print("Error saving profile data: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error saving profile data: $e")),
        );
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
              leading: const Icon(Icons.photo_camera),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                final imagePath = await _pickImage(ImageSource.camera);
                if (imagePath != null) {
                  setState(() {
                    _profilePicture = imagePath;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final imagePath = await _pickImage(ImageSource.gallery);
                if (imagePath != null) {
                  setState(() {
                    _profilePicture = imagePath;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    return image?.path;
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF5565E8),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Profile",
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
                        backgroundImage: _profilePicture != null
                            ? FileImage(File(_profilePicture!))
                            : const NetworkImage("") as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt,
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
                  _buildTextField(
                    'First Name',
                    _firstNameController,
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    'Last Name',
                    _lastNameController,
                    icon: Icons.person,
                  ),
                  _buildTextField(
                    'Phone Number',
                    _phoneController,
                    icon: Icons.phone,
                  ),
                  _buildTextField(
                    'Date of Birth',
                    _dateOfBirthController,
                    icon: Icons.calendar_today,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          'Height',
                          _heightController,
                          icon: Icons.height,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          'Weight',
                          _weightController,
                          icon: Icons.monitor_weight,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfileData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5565E8),
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
              icon != null ? Icon(icon, color: const Color(0xFF5565E8)) : null,
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
