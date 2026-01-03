import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

// Shared theme color
const Color kPrimaryDarkBlue = Color(0xFF032BA7);

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  final List<Map<String, String>> faqs = const [
    {
      'question': 'What is the KIT Team?',
      'answer':
      'The KIT Team is a student-led technical team focused on technology, programming, and digital creativity. It aims to empower students through training courses, workshops, and real-world projects.'
    },
    {
      'question': 'Is the KIT Team affiliated with a university?',
      'answer':
      'No, the KIT Team is an independent team and is not officially affiliated with any university. However, many of its members are university students.'
    },
    {
      'question': 'How can I join the KIT Team?',
      'answer':
      'You can apply through the "Join Us" section by filling out the application form. Applications are reviewed periodically, and selected applicants will be contacted.'
    },
    {
      'question': 'Who can apply to join the KIT Team?',
      'answer':
      'Any student or beginner interested in technology, programming, design, or IT fields can apply, regardless of their academic background.'
    },
    {
      'question': 'What types of courses does KIT offer?',
      'answer':
      'KIT offers courses and workshops in programming, web development, cybersecurity, UI/UX design, databases, and other technical fields.'
    },
    {
      'question': 'Are the courses free or paid?',
      'answer':
      'Some courses are free, while others may be paid depending on the content, duration, and instructors involved.'
    },
    {
      'question': 'Do I receive a certificate after completing a course?',
      'answer':
      'Yes, participants who successfully complete a course or workshop receive a certificate of completion from the KIT Team.'
    },
    {
      'question': 'How can I contact the KIT Team?',
      'answer':
      'You can reach us through the Contact Us section, email, or our official social media platforms.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequently Asked Questions'),
        backgroundColor: kPrimaryDarkBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ExpansionTile(
                iconColor: kPrimaryDarkBlue,
                collapsedIconColor: kPrimaryDarkBlue,
                title: Text(
                  faq['question']!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryDarkBlue,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Text(
                      faq['answer']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
