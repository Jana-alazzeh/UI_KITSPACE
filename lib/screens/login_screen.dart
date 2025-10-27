import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/core/const/api_const.dart';
import 'package:untitled/core/utils/shared_preferences_helper.dart';
import '../core/const/colors.dart';
import 'signUp_screen.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isChecked = false;

  Future<void> login({
    required String phone,
    required  String password,
  }) async {
    try {
      final body = {
        'phone': phone,
        'password': password,
      };

      var response = await http.post(
        Uri.parse(ApiConst.Login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        String token = result['access_token'];
        String user_id=result['user']['id'];
        String user_username=result['user']['id'];
        String user_email=result['user']['email'];
        String user_phone=result['user']['phone'];
        String user_role=result['user']['role'];
        print("Token is : $token");
        await SharedPreferencesHelper.saveString("token", token);
        await SharedPreferencesHelper.saveString("user_id", user_id);
        await SharedPreferencesHelper.saveString("user_username", user_username);
        await SharedPreferencesHelper.saveString("user_email", user_email);
        await SharedPreferencesHelper.saveString("user_phone", user_phone);
        await SharedPreferencesHelper.saveString("user_role", user_role);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homescreen()),
        );

      }
    } catch (e) {
      print(e);

    }
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) async {
                    setState(() {
                      isChecked = value!;
                    });
                    await SharedPreferencesHelper.saveBool("remember", isChecked);
                  },
                ),
                const Text("Remember me"),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                if (phone.text.isNotEmpty && password.text.isNotEmpty) {

                  await login(
                    phone: phone.text,
                    password: password.text,
                  );


                  if (isChecked) {
                    await SharedPreferencesHelper.saveBool("remember", true);
                  }



                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill in all fields.")),
                  );
                }
              },
              child: Container(
                height: height * 0.05,
                width: width * 0.44,
                decoration: BoxDecoration(
                  color: COLORs.midPink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(child: Text("Login")),
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}