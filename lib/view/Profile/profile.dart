import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:tubes_pbp_6/view/Profile/editprofile.dart';
import 'package:tubes_pbp_6/view/login_register/login.dart';
import 'package:tubes_pbp_6/view/home.dart';
import 'package:tubes_pbp_6/view/bookClass/booking.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyWidget> with TickerProviderStateMixin {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? gender;
  String? dateOfBirth;
  String? height;
  String? weight;
  String? profileImagePath;

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 4,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController?.dispose();
    super.dispose();
  }

  // Load profile data from SharedPreferences
  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      firstName = prefs.getString('firstName') ?? 'No firstName';
      lastName = prefs.getString('lastName') ?? 'No lastName';
      email = prefs.getString('email') ?? 'No Email';
      phone = prefs.getString('phone') ?? 'No Phone';
      gender = prefs.getString('gender') ?? 'No Gender';
      dateOfBirth = prefs.getString('dateOfBirth') ?? 'No Date of Birth';
      height = prefs.getString('height') ?? 'No Height';
      weight = prefs.getString('weight') ?? 'No Weight';
      profileImagePath = prefs.getString('profileImagePath');
    });
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
          MaterialPageRoute(builder: (context) => const MyWidget()),
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF5565E8),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
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
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white, // Background for the image
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: profileImagePath != null
                          ? FileImage(File(profileImagePath!))
                          : const AssetImage('images/download.jpg')
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    firstName != null
                        ? firstName!
                        : 'No Name', // Menampilkan firstName
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    lastName != null
                        ? lastName!
                        : 'No Email', // Menampilkan email
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
                  _buildProfileField('No Telephone', phone!, Icons.phone),
                  _buildProfileField(
                      'Date of Birth', dateOfBirth!, Icons.calendar_today),
                  Row(
                    children: [
                      Expanded(
                        child:
                            _buildProfileField('Height', height!, Icons.height),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildProfileField(
                            'Weight', weight!, Icons.monitor_weight),
                      ),
                    ],
                  ),
                  _buildProfileField('Gender', gender!, Icons.person),
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
                    _loadProfileData(); // Refresh data if profile is updated
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

  // Widget to build the profile field
  Widget _buildProfileField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: value),
        enabled: false, // Non-editable for Profile Page
        readOnly: true, // Ensure the field is not editable
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
