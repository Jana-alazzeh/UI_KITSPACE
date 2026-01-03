import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/app_theme.dart';
import 'package:untitled/screens/chatbot_screen.dart';
import 'package:untitled/screens/contact_us_screen.dart';
import 'package:untitled/screens/faq_screen.dart';
import 'package:untitled/screens/signUp_screen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'package:untitled/screens/homescreen.dart';
import 'package:untitled/screens/store_screen.dart';
import 'package:untitled/screens/services_screen.dart';
import 'package:untitled/screens/projects_screen.dart';
import 'package:untitled/screens/courses_screen.dart';
import 'package:untitled/screens/cart_screen.dart';
import 'package:untitled/screens/checkout_screen.dart';
import 'package:untitled/screens/main_screen.dart';
import 'package:untitled/screens/profile_screen.dart';
import 'package:untitled/screens/edit_profile_screen.dart';
import 'package:provider/provider.dart'; // موجودة عندك
import 'package:untitled/screens/cart_provider.dart'; // موجودة عندك

void main() {
  debugPaintSizeEnabled = false;

  // يجب تغليف التطبيق بـ ChangeNotifierProvider هنا
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // لإخفاء شريط Debug
      title: 'KIT App',
      theme: AppTheme.lightTheme,

      initialRoute: '/splash',
      routes: {
        '/': (context) => const MainScreen(),
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const Homescreen(),
        '/store': (context) => const StoreScreen(),
        '/services': (context) => const ServicesScreen(),
        '/projects': (context) => const ProjectsScreen(),
        '/courses': (context) => const CoursesScreen(),
        '/cart': (context) => const CartScreen(),
        '/checkout': (context) => const CheckoutScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/SignUp': (context) => const SignUpScreen(),
        '/FAQ':  (context) => const FaqScreen(),
        '/CHAT': (context) => const ChatbotScreen(),
        '/Contact': (context) => const ContactUsScreen(),


      },
    );
  }
}