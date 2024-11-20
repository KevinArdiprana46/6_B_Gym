import 'dart:io';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_pbp_6/view/Profile/editprofile.dart';
import 'package:tubes_pbp_6/view/Profile/aboutus.dart';
import 'package:tubes_pbp_6/view/Profile/setting.dart';
import 'package:tubes_pbp_6/view/bookClass/booking.dart';
import 'package:tubes_pbp_6/view/login_register/login.dart';
import 'package:tubes_pbp_6/view/home.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  String username = 'Fahmy';
  String email = 'fahmy8394@gmail.com';
  String phone = '+62 821-5766-3661';
  String gender = 'Male';
  String age = '20 years';
  String height = '150 cms';
  String weight = '55 kgs';
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

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? 'Fahmy';
      email = prefs.getString('email') ?? 'fahmy8394@gmail.com';
      phone = prefs.getString('phone') ?? '+62 821-5766-3661';
      gender = prefs.getString('gender') ?? 'Male';
      age = prefs.getString('age') ?? '20 years';
      height = prefs.getString('height') ?? '150 cms';
      weight = prefs.getString('weight') ?? '55 kgs';
      profileImagePath = prefs.getString('profileImagePath');
    });
  }

  void _onItemTapped(int index) {
    if (index != _motionTabBarController!.index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BerandaView()),
          ).then((_) {
            // Memastikan navbar di-update setelah navigasi selesai
            setState(() {
              _motionTabBarController?.index = index;
            });
          });
          break;
        // Uncomment and implement similar cases for other tabs if needed
        // booking
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BookClass()),
          ).then((_) {
            // Memastikan navbar di-update setelah navigasi selesai
            setState(() {
              _motionTabBarController?.index = index;
            });
          });
        break;
        case 4:
          // Tidak melakukan apa-apa karena sudah di halaman Profile
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5565E8),
        automaticallyImplyLeading: false,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFF5565E8),
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Profile',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: profileImagePath != null
                              ? FileImage(File(profileImagePath!))
                              : const AssetImage('images/download.jpg')
                                  as ImageProvider,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.mail,
                                    color: Colors.white70, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  email,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.phone,
                                    color: Colors.white70, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  phone,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ),
                            );
                            _loadProfileData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 8),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                                color: Color(0xFF5565E8),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gender: $gender',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          'Age: $age',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Height: $height',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          'Weight: $weight',
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.info_outline,
                        title: 'About Us',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.settings,
                        title: 'Setting',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
                            ),
                          );
                        },
                      ),
                      ProfileMenuItem(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF5565E8)),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Color(0xFFBDBDBD), size: 16),
          ],
        ),
      ),
    );
  }
}
