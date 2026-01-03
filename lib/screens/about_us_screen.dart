import 'package:flutter/material.dart';

// تعريف الألوان (تأكد من وجودها أو استيرادها)
const Color kPrimaryDarkBlue = Color(0xFF032BA7);

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  final List<Map<String, String>> teamMembers = const [
    {'name': 'Ahmed', 'role': 'Leader and Founder', 'image': 'assets/images/member1.png'},
    {'name': 'Sara', 'role': 'UI/UX Designer', 'image': 'assets/images/member2.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40), // مسافة تفصلها عن محتوى الهوم العلوي
        const Divider(thickness: 1, indent: 20, endIndent: 20),
        const SizedBox(height: 30),

        Text(
          'Who We Are',
          style: const TextStyle(
            color: kPrimaryDarkBlue,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),

        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Image.asset(
            'assets/Images/Screenshot 2025-11-11 162725.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200, color: Colors.grey.shade300,
              child: const Center(child: Text("Image Missing")),
            ),
          ),
        ),
        const SizedBox(height: 25),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'KIT Space',
            style: TextStyle(color: Colors.black87, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),

        const Text(
          'is a youth-driven tech community that combines innovation with purpose. We offer courses, workshops, and real-world projects to empower learners and make a positive impact.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
        ),
        const SizedBox(height: 30),

        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Our Team',
            style: TextStyle(color: kPrimaryDarkBlue, fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        _buildTeamGrid(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildTeamGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.75,
      ),
      itemCount: teamMembers.length,
      itemBuilder: (context, index) {
        final member = teamMembers[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40, backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(member['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(member['role']!, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}