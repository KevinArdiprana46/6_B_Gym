import 'package:flutter/material.dart';
import 'package:tubes_pbp_6/view/booking.dart';
import 'package:tubes_pbp_6/view/profile.dart';

class BerandaView extends StatefulWidget {
  const BerandaView({super.key});

  @override
  State<BerandaView> createState() => _HomeViewState();
}

class _HomeViewState extends State<BerandaView> {
  int _selectedIndex = 0;
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
        Text('ATMA GYM', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
        Text('Selamat Siang'),
        Text('Mulailah Olahraga, Demi Kesehatan yang Tiada Tara', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, fontFamily: 'Montserrat')),
      ],
    ),
  ),
  BookClass(),
  MyWidget(),
  Center(
    child: Column(
      children: [
        Text('Haii'),
        
      ],
    ),
  ),
  
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.list,),label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}