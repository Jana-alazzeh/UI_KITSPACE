import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/const/colors.dart';
import 'package:untitled/core/presentation/custom_button.dart';
import 'package:untitled/core/presentation/custom_textfeild.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CustomWidgetScreen extends StatefulWidget {
  const CustomWidgetScreen({super.key});

  @override
  State<CustomWidgetScreen> createState() => _CustomWidgetScreenState();
}

class _CustomWidgetScreenState extends State<CustomWidgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Screen"),
        backgroundColor: COLORs.Primary,
        centerTitle: true,
        elevation: 0,
      ),

      body: Center(


          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: "https://tse1.mm.bing.net/th/id/OIP.V4syWxe6mQjJmbcoAzQnUQHaFj?rs=1&pid=ImgDetMain&o=7&rm=3",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 900,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text("Hello".tr()),
                //the Custom TextField
                CustomTextField(
                  hintText: "Email".tr(),
                  prefixIcon: Icons.email,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hintText: "Password".tr(),
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),



                SizedBox(height: 30),



                //the custom Buttom
                CustomButton(
                  buttontext: "Login".tr(),
                  color: COLORs.Primary,
                ),

                SizedBox(height: 5),

                CustomButton(
                  buttontext: "Sign Up".tr(),
                  color: COLORs.lightPink,
                ),

                SizedBox(height: 5),
                CustomButton(
                  buttontext: "change_language".tr(),
                  color: COLORs.DarkPink,
                  onTap: () {
                    context.setLocale(
                        context.locale.languageCode == 'ar' ? Locale('en') : Locale('ar')
                    );
                  },
                ),



                SizedBox(height: 20),


                Text(
                  "Welcome to the app!".tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),

      ),
    );
  }
}
