import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:tubes_pbp_6/client/UserClient.dart';
import 'package:tubes_pbp_6/view/Profile/profile.dart';
import 'package:tubes_pbp_6/view/bookClass/booking.dart';
import 'package:tubes_pbp_6/view/bookClass/cart_page.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _BerandaViewState();
}

class _BerandaViewState extends State<BerandaView>
    with TickerProviderStateMixin {
  String? username; // Variabel untuk menyimpan nama user
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    _fetchUserLogin(); // Panggil data user saat halaman dimuat
  }

  Future<void> _fetchUserLogin() async {
    try {
      final user = await UserClient.getUserLogin(); // Panggil API
      setState(() {
        username = user['nama_depan']; // Simpan nama depan user
      });
    } catch (e) {
      setState(() {
        username = 'User'; // Tampilkan 'User' jika terjadi error
      });
    }
  }

  @override
  void dispose() {
    _motionTabBarController!.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BerandaView()),
        );
        break;
      case 1:
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage()));
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookClass()),
        );
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UNI FIT"),
        backgroundColor: const Color(0xFF5565E8),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
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
      body: HomeContent(username: username), // Kirim username ke HomeContent
    );
  }
}

class HomeContent extends StatelessWidget {
  final String? username;

  const HomeContent({Key? key, required this.username}) : super(key: key);
  void _fetchUserLogin() async {
    await UserClient.getUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    _fetchUserLogin();
                  },
                  child: Text(
                    "Morning, ${username ?? 'Loading...'}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("Exercise Schedule:",
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today,
                          size: 16, color: Colors.white),
                      label: const Text("Monday, 14 Oktober",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5565E8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Chip(
                        label: Text("Aerobic",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Color(0xFF5565E8)),
                    SizedBox(width: 8),
                    Chip(
                        label: Text("Boxing",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Color(0xFF5565E8)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("Training Schedule:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  4, (index) => _buildTrainingCard(context, index)),
            ),
          ),
          const SizedBox(height: 16),
          const Text("Personal Trainer:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  TrainerCard(
                      name: "Tretan",
                      expertise: "Jomok",
                      age: 27,
                      location: "Jogja"),
                  TrainerCard(
                      name: "Aaron Jawa",
                      expertise: "Balap Karung",
                      age: 27,
                      location: "Jogja"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainingCard(BuildContext context, int index) {
    final trainingNames = ["Aerobic", "Boxing", "Zumba", "Telaso"];
    final times = [
      "15.00 - 16.30 WIB",
      "17.00 - 18.30 WIB",
      "17.00 - 18.30 WIB",
      "17.00 - 18.30 WIB"
    ];
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.withOpacity(0.3))
        ],
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('lib/assets/image.png', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(trainingNames[index],
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(times[index]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TrainerCard extends StatelessWidget {
  final String name;
  final String expertise;
  final int age;
  final String location;

  const TrainerCard({
    Key? key,
    required this.name,
    required this.expertise,
    required this.age,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('images/download.jpg',
                  width: 150, height: 200, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Expertise: $expertise"),
                  Text("Age: $age Years"),
                  Text("Location: $location"),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildAvailabilityChip("Monday"),
                      _buildAvailabilityChip("Tuesday"),
                      _buildAvailabilityChip("Wednesday"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityChip(String day) {
    return SizedBox(
      width: 100,
      child: Chip(
          label: Text(day,
              style: const TextStyle(color: Colors.white, fontSize: 10)),
          backgroundColor: const Color(0xFF5565E8)),
    );
  }
}
