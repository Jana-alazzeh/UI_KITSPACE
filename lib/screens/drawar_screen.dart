import 'package:flutter/material.dart';

import '../core/const/colors.dart';


class DrawarScreen extends StatefulWidget {
  const DrawarScreen({super.key});

  @override
  State<DrawarScreen> createState() => _DrawarScreenState();
}

class _DrawarScreenState extends State<DrawarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jana"),
        backgroundColor: COLORs.Primary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: COLORs.Primary,
              ),
              child: Column(

                children:  [
                  Text(
                    "Jana",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "jana.alazzeh@gmail.com",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Search"),
              onTap: () {},
            ),

            ExpansionTile(
              leading: const Icon(Icons.settings, color: Colors.pink),
              title: const Text("Settings"),
              children: [
                ListTile(
                  leading: const Icon(Icons.folder),
                  title: const Text("folder"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profile"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text("Notifications"),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About"),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
