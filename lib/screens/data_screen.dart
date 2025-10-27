import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}


class _DataScreenState extends State<DataScreen> {

  String userId = '1';
  String userName = 'jana';
  String mail = 'jana@gmail.com';
  String phone = '0775264950';
  String role = 'admin';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDate();
  }

  Future<void> getDate() async {

    Future<void> getDate() async {
      final prefs = await SharedPreferences.getInstance();

      setState(() {
        userId = prefs.getString("user_id") ?? '1';
        userName = prefs.getString("user_username") ?? 'jana';
        mail = prefs.getString("user_email") ?? 'jana@gmail.com';
        phone = prefs.getString("user_phone") ?? '0775264950';
        role = prefs.getString("user_role") ?? 'admin';
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" user data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Text(" $userId", style: const TextStyle(fontSize: 18)),
            const Divider(),
            Text(" $userName", style: const TextStyle(fontSize: 18)),
            const Divider(),
            Text("$mail", style: const TextStyle(fontSize: 18)),
            const Divider(),
            Text("$phone", style: const TextStyle(fontSize: 18)),
            const Divider(),
            Text(" $role", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}