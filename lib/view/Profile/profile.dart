import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:tubes_pbp_6/client/profileClient.dart';
import 'package:tubes_pbp_6/view/Profile/editprofile.dart';
import 'package:tubes_pbp_6/view/login_register/login.dart';
import 'package:tubes_pbp_6/view/home.dart';
import 'package:tubes_pbp_6/view/bookClass/booking.dart';
import 'package:tubes_pbp_6/entity/profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? profile_picture;

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 4,
      length: 5,
      vsync: this,
    );
    _loadProfileData();
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  // Load profile data from API
  Future<void> _loadProfileData() async {
    try {
      final response = await ProfileClient.getProfile();
      if (response.statusCode == 200) {
        final profileData = Profile.fromJson(jsonDecode(response.body));

        if (mounted) {
          setState(() {
            firstName = profileData.nama_depan ?? 'No firstName';
            lastName = profileData.nama_belakang ?? 'No lastName';
            email = profileData.email ?? 'No Email';
            phone = profileData.nomor_telepon ?? 'No Phone';
            gender = profileData.jenis_kelamin ?? 'No Gender';
            dateOfBirth = profileData.tanggal_lahir ?? 'No Date of Birth';
            height = profileData.height.toString() ?? 'No Height';
            weight = profileData.weight.toString() ?? 'No Weight';
            profile_picture = profileData.profile_picture ?? 'No Picture';
          });
        }
      } else {
        throw Exception("Failed to fetch profile data");
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  // Handling tab selection
  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BerandaView()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookClass()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  // Logout function
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              color: const Color(0xFF5565E8),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // tombol logout di pojok kanan
                    children: [
                      IconButton(
                        color: Colors.red,
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        tooltip: 'Logout',
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: profile_picture != null
                          ? FileImage(File(profile_picture!))
                          : const AssetImage('images/download.jpg')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    firstName ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email ?? 'No Email',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Data Fields
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildProfileField(
                      'No Telephone', phone ?? 'N/A', Icons.phone),
                  _buildProfileField('Date of Birth', dateOfBirth ?? 'N/A',
                      Icons.calendar_today),
                  Row(
                    children: [
                      Expanded(
                        child: _buildProfileField(
                            'Height', height ?? 'N/A', Icons.height),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildProfileField(
                            'Weight', weight ?? 'N/A', Icons.monitor_weight),
                      ),
                    ],
                  ),
                  _buildProfileField('Gender', gender ?? 'N/A', Icons.person),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Edit Profile Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    ),
                  );
                  if (result == true) {
                    _loadProfileData(); // Refresh data
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5565E8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Profile",
        labels: const ["Home", "Review", "Booking", "Payment", "Profile"],
        icons: const [
          Icons.home,
          Icons.reviews,
          Icons.calendar_month_outlined,
          Icons.shopping_cart,
          Icons.people_alt,
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Colors.blue[600],
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Colors.blue[900],
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: _onItemTapped,
      ),
    );
  }

  // field untuk profile
  Widget _buildProfileField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: false,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF5565E8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
