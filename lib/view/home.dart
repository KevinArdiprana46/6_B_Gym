import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/view_list.dart';
import 'package:tubes_pbp_6/view/profile.dart';
import 'package:tubes_pbp_6/view/editprofile.dart';

class BerandaView extends StatefulWidget {
  final int initialIndex;

  const BerandaView(
      {super.key, this.initialIndex = 0}); // Tambahkan parameter initialIndex

  @override
  State<BerandaView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BerandaView> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // Inisialisasi selectedIndex
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('images/download.jpg')),
          Text('ATMA GYM',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat')),
          Text('Selamat Siang'),
          Text('Mulailah Olahraga, Demi Kesehatan yang Tiada Tara',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Montserrat')),
        ],
      ),
    ),
    ListLayanan(),
    Center(
      child: Column(
        children: [
          Text('Review Page'),
        ],
      ),
    ),
    Center(
      child: Column(
        children: [
          Text('Calendar Page'),
        ],
      ),
    ),
    MyWidget(),
    Center(
      child: Column(
        children: [
          Text('Profile'),
        ],
      ),
    ),
    EditProfile(), // Tambahkan halaman EditProfile sebagai opsi dalam _widgetOptions
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromRGBO(85, 101, 232, 100),
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
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
