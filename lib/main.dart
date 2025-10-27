import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/screens/grid_view_screen.dart';
import 'package:untitled/screens/image_picker_screen.dart';
import 'package:untitled/screens/images.dart';
import 'package:untitled/screens/login_screen.dart';
import 'package:untitled/screens/signUp_screen.dart';
import 'package:untitled/screens/splash_screen.dart';
import 'screens/custom_widget_screen.dart';
import 'screens/home_screen.dart';
import 'screens/homescreen.dart';
import 'screens/list_view_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/sqlflite_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  debugPaintSizeEnabled = false;

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates, // مهم
      supportedLocales: context.supportedLocales,           // مهم
      locale: context.locale,                               // مهم
      home:SignUpScreen(),
    );
  }
}
