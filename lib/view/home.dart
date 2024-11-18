import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/view_list.dart';
import 'package:tubes_pbp_6/view/Profile/profile.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BerandaView> with TickerProviderStateMixin{
  MotionTabBarController? _motionTabBarController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text("List Layanan")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 228, 228, 228),
      appBar: AppBar(
        backgroundColor: Color(0xFF5565E8),
        title: const Text("UNI FIT", style: TextStyle(color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Image.asset('lib/assets/Logo 3.png', fit: BoxFit.contain),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
          IconButton(icon: Icon(Icons.settings, color: Colors.white), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // Add this controller if you need to change your tab programmatically
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Dashboard", "Home", "Profile", "Settings"],
        icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],

        // optional badges, length must be same with labels
        badges: [
          // Default Motion Badge Widget
          const MotionBadgeWidget(
            text: '10+',
            textColor: Colors.white, // optional, default to Colors.white
            color: Colors.red, // optional, default to Colors.red
            size: 18, // optional, default to 18
          ),

          // custom badge Widget
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(2),
            child: const Text(
              '48',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),

          // allow null
          null,

          // Default Motion Badge Widget with indicator only
          const MotionBadgeWidget(
            isIndicator: true,
            color: Colors.red, // optional, default to Colors.red
            size: 5, // optional, default to 5,
            show: true, // true / false
          ),
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
        onTabItemSelected: (int value) {
          switch (value) {
    case 0:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BenuPage()),
      // );
      break;
    case 1:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => HomePage()),
      // );
      break;
    case 2:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ReviewPage()),
      // );
      break;
    case 3:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => BookingPage()),
      // );
      break;
    case 4:
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => PembayaranPage()),
      // );
      break;
    case 5:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyWidget()), // Profile page
      );
      break;
    default:
      setState(() {
        _motionTabBarController!.index = value;
      });
  }
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _motionTabBarController,
        children: <Widget>[
          HomeScreen(title: "Dashboard Page", controller: _motionTabBarController!),
          HomeScreen(title: "Home Page", controller: _motionTabBarController!),
          HomeScreen(title: "Profile Page", controller: _motionTabBarController!),
          HomeScreen(title: "Settings Page", controller: _motionTabBarController!),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    required this.title,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final String title;
  final MotionTabBarController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise Schedule box
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Morning, Fahmy", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text("Exercise Schedule:", style: TextStyle(fontSize: 16)),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.calendar_today, size: 16, color: Colors.white),
                      label: Text("Monday, 14 Oktober", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5565E8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Chip(label: Text("Aerobic", style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF5565E8)),
                    SizedBox(width: 8),
                    Chip(label: Text("Boxing", style: TextStyle(color: Colors.white)), backgroundColor: Color(0xFF5565E8)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text("Training Schedule:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          // Training Schedule horizontal scroll
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(4, (index) => _buildTrainingCard(context, index)),
            ),
          ),
          SizedBox(height: 16),
          Text("Personal Trainer:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          // Personal Trainer section
          SizedBox(
            height: 300,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TrainerCard(name: "Tretan", expertise: "Jomok", age: 27, location: "Jogja"),
                  TrainerCard(name: "Aaron Jawa", expertise: "Balap Karung", age: 27, location: "Jogja"),
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
    final times = ["15.00 - 16.30 WIB", "17.00 - 18.30 WIB", "17.00 - 18.30 WIB", "17.00 - 18.30 WIB"];
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.grey.withOpacity(0.3))],
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('lib/assets/image.png', fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(trainingNames[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset('images/download.jpg', width: 150, height: 200, fit: BoxFit.cover),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      child: Chip(label: Text(day, style: TextStyle(color: Colors.white, fontSize: 10)), backgroundColor: Color(0xFF5565E8)),
    );
  }
}
