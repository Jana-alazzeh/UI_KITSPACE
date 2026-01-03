import 'package:flutter/material.dart';
import 'package:untitled/screens/courses_screen.dart';


class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // استخدمنا Scaffold ليعطيكِ هيكل الصفحة الصحيح
      backgroundColor: const Color(0xFFCCCCE5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // عنوان الصفحة
              const Center(
                child: Text(
                  'Our Services',
                  style: TextStyle(
                    color: Color(0xFF032BA7),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // الصورة الرئيسية
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/Images/services_class_photo.png',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(child: Text("Image Missing")),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Learn, Create, Achieve',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Explore our range of courses, workshops, and tech projects designed to help you learn, grow, and make an impact.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),

              const SizedBox(height: 30),

              // زر "Our Courses" مع منطق الانتقال
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // هذا هو الكود الذي يفتح صفحة الكورسات
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CoursesScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF032BA7),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Our Courses',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}