import 'package:flutter/material.dart';
import 'package:untitled/screens/drawar_screen.dart';
import 'package:untitled/screens/grid_view_screen.dart';
import 'package:untitled/screens/list_view_screen.dart';
import 'package:untitled/screens/login_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  List<Widget> screens = [
    ListViewScreen(),
    GridViewScreen(),
    DrawarScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(child: screens[_selectedIndex]), // عرض الشاشة المناسبة
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink[50],
        selectedItemColor: Colors.pink[400],
        unselectedItemColor: Colors.pink[200],
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home Screen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search Screen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile Screen",
          ),
        ],
      ),
    );
  }
}
