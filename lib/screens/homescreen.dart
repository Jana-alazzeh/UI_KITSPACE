import 'package:flutter/material.dart';
import 'package:untitled/app_theme.dart';
import 'package:untitled/screens/login_screen.dart' show LoginScreen;
import 'package:untitled/screens/signUp_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackgroundImage(screenHeight),
          _buildMainScrollableContent(context, screenHeight),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(double screenHeight) {
    return Container(
      height: screenHeight,
      decoration: const BoxDecoration(color: AppTheme.primaryColor),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/Images/Screenshot 2025-11-10 220208.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: screenHeight,
              color: Colors.blue.shade800,
            ),
          ),
          Container(decoration: BoxDecoration(color: Colors.black.withOpacity(0.3))),
        ],
      ),
    );
  }

  Widget _buildMainScrollableContent(BuildContext context, double screenHeight) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // قسم الهوم الأساسي
          Container(
            height: screenHeight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 100),
                const Text(
                  'Lets Speak IT Fluently!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Master tech skills and join our vibrant community',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),
                _buildActionButtons(context),
              ],
            ),
          ),
          // قسم About Us المنظف
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: const AboutUsSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: Colors.white, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            child: const Text('Sign Up', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

// الكلاس بعد حذف "Our Team" تماماً
class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text(
          'Who We Are',
          style: TextStyle(color: AppTheme.primaryColor, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 25),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            'assets/Images/Screenshot 2025-11-11 162725.png',
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: Colors.grey.shade300,
              child: const Center(child: Text("Image Missing")),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('KIT Space', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 10),
        const Text(
          'is a youth-driven tech community that combines innovation with purpose. We offer courses, workshops, and real-world projects to empower learners and make a positive impact.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}