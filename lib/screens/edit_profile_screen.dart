import 'package:flutter/material.dart';

// تعريف الألوان المشتركة
const Color kPrimaryDarkBlue = Color(0xFF032BA7);
const Color kScaffoldBackground = Color(0xFFF7F7F7);
const Color kInputFillColor = Color(0xFFEFEFEF);

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // متحكمات الحقول
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // TODO: قم بتحميل بيانات المستخدم الحالية من الـ Shared Preferences أو الـ API هنا
    _loadUserData();
  }

  void _loadUserData() {
    // مثال لملء الحقول ببيانات وهمية
    _nameController.text = "Jana Alazzeh";
    _usernameController.text = "jana.a";
    _genderController.text = "Female"; // يفضل استخدام DropdownButton لهذا الحقل
    _phoneController.text = "0790123456";
    _emailController.text = "jana@kit.com";
  }

  Future<void> _saveProfileChanges() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: قم بتنفيذ منطق حفظ البيانات إلى الـ API هنا
    await Future.delayed(const Duration(seconds: 2)); // محاكاة عملية الحفظ

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      // يمكنك العودة للصفحة السابقة بعد الحفظ
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackground,
      // 🛑 لا يوجد BottomNavigationBar هنا (لأنه يجب أن يختفي في شاشات الإعدادات الفرعية)

      appBar: AppBar(
        // إزالة الظل (elevation) لتتماشى مع النمط البسيط
        elevation: 0,
        backgroundColor: kScaffoldBackground,
        automaticallyImplyLeading: false, // نتحكم بزر العودة يدوياً
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // زر العودة للخلف
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kPrimaryDarkBlue),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. حقل الاسم
            _buildTextFieldWithTitle(
              title: 'Name',
              controller: _nameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25),

            // 2. حقل اسم المستخدم
            _buildTextFieldWithTitle(
              title: 'Username',
              controller: _usernameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25),

            // 3. حقل النوع (Gender)
            _buildTextFieldWithTitle(
              title: 'Gender',
              controller: _genderController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 25),

            // 4. حقل رقم الهاتف
            _buildTextFieldWithTitle(
              title: 'Phone Number',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 25),

            // 5. حقل البريد الإلكتروني
            _buildTextFieldWithTitle(
              title: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              readOnly: true, // قد يكون البريد الإلكتروني غير قابل للتعديل
            ),
            const SizedBox(height: 50),

            // 6. زر الحفظ
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  // **********************************
  // الدوال المساعدة (Helper Methods)
  // **********************************

  // دالة بناء حقل إدخال مع عنوان (مطابقة للتصميم)
  Widget _buildTextFieldWithTitle({
    required String title,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: kInputFillColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  // دالة بناء زر الحفظ
  Widget _buildSaveButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _saveProfileChanges,
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryDarkBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          'Save',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}