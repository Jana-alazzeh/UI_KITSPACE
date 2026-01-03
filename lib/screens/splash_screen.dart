import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:untitled/core/utils/shared_preferences_helper.dart'; // Import removed as logic is commented out

// تعريف اللون الأزرق الداكن المستخدم في التصميم
const Color kPrimaryBlue = Color(0xFF032BA7);
const Color kDarkBlue = Color(0xFF032BA7); // لون الحدود المحيطة (Darker Blue)

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

  // منطق التنقل المعدل: دائماً يذهب إلى شاشة MainScreen (التي تحتوي على BottomNavigationBar)
  goTo() async {
    // TODO: Add logic to check for login status here if needed.
    // For now, we navigate to the main app shell.

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) { // التحقق من أن الـ Widget لا يزال موجوداً قبل التنقل
        // التوجيه إلى MainScreen (الـ '/') مباشرة
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlue,
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: kPrimaryBlue,
            width: 10.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الصورة
                Image.asset(
                  'assets/Images/kit.png',
                  width: 140,
                  height: 140,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: 60,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // النص الرئيسي "KIT"
                const Text(
                  'KIT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),

                const SizedBox(height: 8),

                // النص الفرعي
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'KEY OF INFORMATION TECHNOLOGY',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // مؤشر التحميل
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
