import 'package:flutter/material.dart';
import 'package:untitled/screens/store_screen.dart';
import 'package:untitled/screens/services_screen.dart';
import 'package:untitled/screens/projects_screen.dart';
import 'package:untitled/screens/homescreen.dart';
import 'package:untitled/screens/todo_screen.dart';
import 'package:untitled/app_theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<Widget> _screens = const [
    Homescreen(),
    StoreScreen(),
    ServicesScreen(),
    ProjectsScreen(),
    TodoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildCustomAppBar(),
      drawer: _buildSideDrawer(), // ✅ Drawer مربوط
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ================= Drawer =================
  Widget _buildSideDrawer() {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF032BA7)),
            child: Center(
              child: Text(
                'KIT Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [

                _buildDrawerItem(Icons.school, 'Courses', '/courses'),
                const Divider(),

                _buildDrawerItem(Icons.question_answer, 'FAQ', '/FAQ'),
                const Divider(),

                _buildDrawerItem(Icons.chat, 'Chatbot', '/CHAT'),
                const Divider(),

                _buildDrawerItem(Icons.contact_mail, 'Contact Us', '/Contact'),



              ],

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String? routeName) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF032BA7)),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Route for $title not defined yet')),
          );
        }
      },
    );
  }

  // ================= AppBar =================
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          children: [
            // Profile
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/profile'),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 22),
              ),
            ),
            const SizedBox(width: 10),

            // Search
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(70),
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Color(0xFF032BA7)),
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: const Color(0xFF032BA7).withOpacity(0.6),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF032BA7)),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            // Menu Button (يفتح Drawer)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= Bottom Nav =================
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: Colors.grey.shade400,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
        BottomNavigationBarItem(icon: Icon(Icons.design_services), label: 'Services'),
        BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: 'Projects'),
        BottomNavigationBarItem(icon: Icon(Icons.checklist), label: 'To-Do'),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
