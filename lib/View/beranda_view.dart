import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/reviewPage.dart';
import 'package:tubes_pbp_6/view/profile.dart';
import 'package:tubes_pbp_6/view/listReview.blade.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BerandaView> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('images/download.jpg')),
          Text(
            'ATMA GYM',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
          ),
          Text('Selamat Siang'),
          Text(
            'Mulailah Olahraga, Demi Kesehatan yang Tiada Tara',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, fontFamily: 'Montserrat'),
          ),
        ],
      ),
    ),
    ListReview(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Review'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
