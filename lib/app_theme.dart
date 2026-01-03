import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF032BA7);
  static const Color accentColor = Color(0xFFF05454);
  static const Color backgroundColor = Color(0xFFF8F8F8);
  static const Color cardColor = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF666666);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false, // ✅ أضفنا هذا لتجنب مشاكل Material3 الجديدة
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Cairo',

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: true,
      elevation: 0,
    ),

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: createMaterialColor(primaryColor),
    ).copyWith(
      secondary: accentColor,
      surface: cardColor,
      brightness: Brightness.light,
    ),

   
//    cardTheme: CardTheme(
 //     color: cardColor,
  //    elevation: 4,
  //    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //    shape: const RoundedRectangleBorder(
  //      borderRadius: BorderRadius.all(Radius.circular(12.0)),
 //     ),
  //  ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
      labelStyle: TextStyle(color: lightTextColor),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textColor),
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: textColor),
      bodyLarge: TextStyle(fontSize: 16.0, color: textColor),
      bodyMedium: TextStyle(fontSize: 14.0, color: lightTextColor),
    ),
  );

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}
