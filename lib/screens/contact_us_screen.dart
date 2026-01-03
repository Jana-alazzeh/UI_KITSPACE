import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  static const Color mainColor = Color(0xFF032BA7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // Back button
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact Form',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),

            _buildTextField(label: 'Full Name'),
            const SizedBox(height: 12),
            _buildTextField(
              label: 'Email Address',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            _buildTextField(label: 'Subject'),
            const SizedBox(height: 12),
            _buildTextField(label: 'Your Message', maxLines: 5),
            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Send Message',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),

            const SizedBox(height: 40),

            Text(
              'Social Media Links',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: mainColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),

            _buildSocialMediaLink(icon: Icons.facebook, title: 'Facebook'),
            _buildSocialMediaLink(icon: Icons.alternate_email, title: 'Email'),
            _buildSocialMediaLink(icon: Icons.link, title: 'Website'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: mainColor),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainColor, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        alignLabelWithHint: true,
      ),
    );
  }

  Widget _buildSocialMediaLink({
    required IconData icon,
    required String title,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: mainColor),
        title: Text(title),
        trailing: const Icon(Icons.open_in_new),
        onTap: () {},
      ),
    );
  }
}
