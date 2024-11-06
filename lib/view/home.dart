import 'package:flutter/material.dart';
import "package:tubes_pbp_6/view/view_list.dart";

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
        Image(image: NetworkImage('https://i.pinimg.com/564x/c2/6a/87/c26a87129b59737f8c3435091810816a.jpg')),
        Text('GYM ABUBAKAR', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Montserrat')),
      ],
    ),
  ),
  ListLayanan(),
  Center(
    child: Column(
      children: [
        Text('Index 3: Profile'),
        Text('Selamat Siang'),
        Text('Mulailah Olahraga, Demi Kesehatan yang Tiada Tara', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal, fontFamily: 'Montserrat')),
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