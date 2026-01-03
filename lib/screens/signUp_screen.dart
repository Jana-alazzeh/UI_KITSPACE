import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

// NOTE: The following imports are commented out as their files were not provided,
// but they are necessary for the original logic.
// import '../core/const/api_const.dart'; // لتحديد مسار الـ API

// تعريف الألوان الجديدة (تقريبية من التصميم) - يجب أن تتطابق مع شاشة Login
const Color kPrimaryDarkBlue = Color(0xFF032BA7); // أزرق داكن للنصوص والأزرار
const Color kLightBackground = Color(0xFFE8EAF6); // لون خلفية الـ Card (أفتح قليلاً)
const Color kInputFillColor = Color(0xFFEFEFEF); // لون خلفية حقل الإدخال

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // تم تغيير المتحكمات لتناسب الحقول الجديدة في التصميم
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isLoading = false; // حالة التحميل
  // تم إبقاء منطق التقاط الصورة رغم حذفه من الـ UI، في حال احتجت إليه لاحقاً
  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // الدوال الخاصة بالتقاط الصورة (لم يتم استخدامها في الـ UI الجديد)
  void _showPickOptionsDialog(BuildContext context) {
    // ... الكود كما هو ...
  }
  Future<void> _pickImage(ImageSource source) async {
    // ... الكود كما هو ...
  }


  Future<void> signUp({
    required String email, // تغيير الاسم إلى email
    required String password,
    required String name,
  }) async {
    if (password != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password and Confirm Password must match.")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final body = {
        'username': name,
        'email': email,
        // يمكنك تعديل هذا إذا كان الـ API يتطلب الـ phone بدلاً من الـ email
        'phone': '',
        'password': password,
      };

      // NOTE: ApiConst.Register is not defined. Using a placeholder URL.
      // var response = await http.post(
      //   Uri.parse(ApiConst.Register),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(body),
      // );

      // Simulate API call success for UI testing
      await Future.delayed(const Duration(seconds: 1));
      int statusCode = 200; // Assume success for now

      if (statusCode == 201 || statusCode == 200) {
        // إذا نجح التسجيل، ننتقل إلى شاشة تسجيل الدخول باستخدام Named Route
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Registration Failed: ${response.body}")),
        // );
      }

    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Error: $e")),
      // );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // تم حذف الـ AppBar واستخدام الـ Stack والـ SingleChildScrollView
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // 1. الخلفية الزرقاء مع تصميم الدوائر الإلكترونية (مطابق للـ Login)
          Container(
            color: const Color(0xFFC0D6E8), // لون الخلفية الأزرق الفاتح
            child: Image.asset(
              'assets/Images/Screenshot 2025-11-10 230917.png', // **تأكد من المسار الصحيح**
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.05),
              colorBlendMode: BlendMode.dstATop,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFC0D6E8),
              ),
            ),
          ),

          // 2. المحتوى الأساسي (يحتوي على الـ Card)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: kLightBackground, // لون خلفية الـ Card
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // زر الرجوع (Back to login)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            // استخدام Named Route
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Back to login',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // عنوان التسجيل
                      Text(
                        'Sign Up',
                        style: const TextStyle(
                          color: kPrimaryDarkBlue,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // حقل الإدخال: Email
                      _buildRoundedInputField(
                        controller: emailController,
                        hintText: 'Email',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // حقل الإدخال: Your Name
                      _buildRoundedInputField(
                        controller: nameController,
                        hintText: 'Your Name',
                        icon: Icons.badge_outlined, // أيقونة مشابهة لـ Name Tag
                      ),
                      const SizedBox(height: 20),

                      // حقل الإدخال: Password
                      _buildRoundedInputField(
                        controller: passwordController,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        isObscure: true,
                      ),
                      const SizedBox(height: 20),

                      // حقل الإدخال: Confirm Password
                      _buildRoundedInputField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        icon: Icons.lock_reset, // أيقونة مشابهة
                        isObscure: true,
                      ),
                      const SizedBox(height: 30),

                      // زر Sign Up
                      _buildSignUpButton(context),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // **********************************
  // الدوال المساعدة (Helper Functions)
  // **********************************

  // دالة بناء حقل الإدخال ذو الشكل البيضاوي (تم نسخها من LoginScreen)
  Widget _buildRoundedInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isObscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kInputFillColor,
        borderRadius: BorderRadius.circular(50), // شكل بيضاوي
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscure,
        style: const TextStyle(color: kPrimaryDarkBlue),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 15),
          prefixIcon: Icon(icon, color: kPrimaryDarkBlue.withOpacity(0.7), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // دالة بناء زر تسجيل الدخول
  Widget _buildSignUpButton(BuildContext context) {
    return InkWell(
      onTap: _isLoading
          ? null
          : () async {
        if (emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty) {
          await signUp(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please fill in all fields.")),
          );
        }
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryDarkBlue,
          borderRadius: BorderRadius.circular(10), // شكل مستطيل بزوايا مستديرة
        ),
        child: Center(
          child: _isLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
              : Text(
            "Sign Up",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
