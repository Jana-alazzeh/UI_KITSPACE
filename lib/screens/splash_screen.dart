import 'package:flutter/material.dart';
import 'package:untitled/core/utils/shared_preferences_helper.dart';
import 'login_screen.dart';
import 'homescreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goTo();
  }

  goTo() async {
    bool loggedIn = await SharedPreferencesHelper.getBool("remember") ?? false;

    if (loggedIn != true) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/Images/unnamed.png', // ضع هنا مسار اللوجو الصحيح
          width: width * 1,
          height: height * 0.3,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
