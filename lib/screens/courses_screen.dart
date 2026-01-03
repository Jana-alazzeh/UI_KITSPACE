import 'package:flutter/material.dart';
import 'package:untitled/app_theme.dart';

const Color kPrimaryDarkBlue = Color(0xFF032BA7);
const Color kScaffoldBackground = Color(0xFFF7F7F7);

final List<Map<String, String>> mockCourses = [
  {
    'title': 'Git & GitHub Course',
    'subtitle': 'Master version control and collaboration...',
    'image': 'assets/images/git_logo.png',
    'buttonText': 'Enroll Now',
  },
  {
    'title': 'CompTIA Security+',
    'subtitle': 'Get essential cybersecurity skills...',
    'image': 'assets/images/security_logo.png',
    'buttonText': 'Start Learning',
  },
  {
    'title': 'Full-Stack Laravel',
    'subtitle': 'Build powerful web apps with Laravel...',
    'image': 'assets/images/laravel_logo.png',
    'buttonText': 'Enroll Now',
  },
  {
    'title': 'System Analysis',
    'subtitle': 'Understand SDLC, Agile, and design.',
    'image': 'assets/images/system_logo.png',
    'buttonText': 'Enroll Now',
  },
];

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 80, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tech Courses',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryDarkBlue,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Master coding and essential tech skills with KIT experts',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Expanded(child: _buildCoursesGrid()),
                ],
              ),
            ),
          ),

          // 🔙 Back Button
          Positioned(
            top: 20,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: kPrimaryDarkBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoursesGrid() {
    return GridView.builder(
      itemCount: mockCourses.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return _buildCourseCard(context, mockCourses[index]);
      },
    );
  }

  Widget _buildCourseCard(BuildContext context, Map<String, String> course) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kPrimaryDarkBlue,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 40,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      course['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  course['subtitle']!,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryDarkBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text(
                      course['buttonText']!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
