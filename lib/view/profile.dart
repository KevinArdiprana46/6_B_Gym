import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/editprofile.dart';
import 'package:tubes_pbp_6/view/aboutus.dart';
import 'package:tubes_pbp_6/view/setting.dart';
import 'package:tubes_pbp_6/view/login.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Custom header using Stack
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(85, 101, 232, 100),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('images/download.jpg'),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 90,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fahmy',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'fahmy8394@gmail.com',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            '+62 821-5766-3661',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              color: Color.fromRGBO(85, 101, 232, 100),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender: Male',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        'Age: 20 years',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 170,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Height: 150 cms',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        'Weight: 55 kgs',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 16),
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
            Icon(icon, color: Color.fromRGBO(85, 101, 232, 100)),
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
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey.shade400, size: 16),
          ],
        ),
      ),
    );
  }
}
