import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Added for jsonEncode/jsonDecode
import 'package:easy_localization/easy_localization.dart'; // Added for localization

// NOTE: The following imports are commented out as their files were not provided,
// but they are necessary for the original logic.
// import 'package:untitled/core/const/api_const.dart';
// import 'package:untitled/core/utils/shared_preferences_helper.dart';

// تعريف الألوان الجديدة (تقريبية من التصميم)
const Color kPrimaryDarkBlue = Color(0xFF032BA7); // أزرق داكن للنصوص
const Color kLightBackground = Color(0xFFD3E0F3); // لون خلفية الـ Card
const Color kInputFillColor = Color(0xFFEFEFEF); // لون خلفية حقل الإدخال

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isChecked = false;
  bool _isLoading = false; // حالة التحميل

  // Placeholder for SharedPreferencesHelper and ApiConst to avoid errors
  // You must ensure these files exist and are correctly implemented in your project.
  Future<void> _saveLoginData(String token, Map<String, dynamic> user) async {
    // await SharedPreferencesHelper.saveString("token", token);
    // await SharedPreferencesHelper.saveString("user_id", user['id'].toString());
    // await SharedPreferencesHelper.saveString("user_username", user['username'] ?? '');
    // await SharedPreferencesHelper.saveString("user_email", user['email']);
    // await SharedPreferencesHelper.saveString("user_phone", user['phone']);
    // await SharedPreferencesHelper.saveString("user_role", user['role']);
  }

  Future<void> login({
    required String phone,
    required String password,
  }) async {
    setState(() {
      _isLoading = true;
    });
    // منطق الـ API الخاص بك هنا...
    try {
      final body = {
        'phone': phone,
        'password': password,
      };

      // NOTE: ApiConst.Login is not defined. Using a placeholder URL.
      // var response = await http.post(
      //   Uri.parse(ApiConst.Login),
      //   headers: {'Content-Type': 'application/json'},
      //   body: jsonEncode(body),
      // );

      // Simulate API call success for UI testing
      await Future.delayed(const Duration(seconds: 1));
      int statusCode = 200; // Assume success for now

      if (statusCode == 200) {
        // var result = jsonDecode(response.body);
        // String token = result['access_token'];
        // await _saveLoginData(token, result['user']);

        // التنقل للصفحة الرئيسية (MainScreen) باستخدام Named Route
        // MainScreen is the new home with the consolidated BottomNavigationBar
        Navigator.pushReplacementNamed(context, '/');
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Login Failed: ${response.body}")),
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
      resizeToAvoidBottomInset: true,
      // نستخدم Stack لوضع الخلفية والـ Form فوقها
      body: Stack(
        children: [
          // 1. الخلفية الزرقاء مع تصميم الدوائر الإلكترونية
          Container(
            color: const Color(0xFFC0D6E8), // لون الخلفية الأزرق الفاتح
            child: Stack(
              children: [
                // 1. الصورة الأصلية بدون أي تراكب لوني (فقط للتأكد من الظهور)
                Image.asset(
                  'assets/images/Screenshot 2025-11-10 230917.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFC0D6E8),
                  ),
                ),

                // 2. تراكب لوني بسيط لتفتيح الخلفية أو تظليلها
                Container(
                  color: Colors.white.withOpacity(0.1), // تراكب أبيض خفيف لجعلها باهتة
                )
              ],
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
                      // عنوان الترحيب
                      Text(
                        'Welcome Back!',
                        style: const TextStyle(
                          fontFamily: 'RobotoSlab',
                          color: kPrimaryDarkBlue,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // حقل الإدخال: Email ID
                      _buildRoundedInputField(
                        controller: phone,
                        hintText: 'Email ID',
                        icon: Icons.person_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      // حقل الإدخال: Password
                      _buildRoundedInputField(
                        controller: password,
                        hintText: 'Password',
                        icon: Icons.lock_outline,
                        isObscure: true,
                      ),
                      const SizedBox(height: 10),

                      // شريط "Remember me" و "Forget Password?"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (value) async {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                    // await SharedPreferencesHelper.saveBool("remember", isChecked);
                                  },
                                  activeColor: kPrimaryDarkBlue,
                                  checkColor: Colors.white,
                                ),
                              ),
                              Text(
                                "Remember me",
                                style: const TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: إضافة منطق نسيت كلمة المرور
                            },
                            child: Text(
                              "Forget Password?",
                              style: const TextStyle(color: kPrimaryDarkBlue, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // زر Login
                      _buildLoginButton(context),
                      const SizedBox(height: 10),

                      // زر Sign Up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account? ", style: const TextStyle(color: Colors.black54)),
                          TextButton(
                            onPressed: () {

                              Navigator.pushNamed(context, '/SignUp');
                            },
                            child: Text(
                              "Sign Up",
                              style: const TextStyle(
                                color: kPrimaryDarkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  // دالة بناء حقل الإدخال ذو الشكل البيضاوي
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
  Widget _buildLoginButton(BuildContext context) {
    return InkWell(
      onTap: _isLoading
          ? null
          : () async {
        if (phone.text.isNotEmpty && password.text.isNotEmpty) {
          await login(
            phone: phone.text,
            password: password.text,
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
          borderRadius: BorderRadius.circular(10),
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
            "Login",
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
