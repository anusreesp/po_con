import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme lightTextTheme = const TextTheme(
      titleLarge: TextStyle(fontSize: 12, color: Colors.black),
      headlineSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xffFFFFFF)),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xffB68708)),
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700));

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      // fontFamily: 'Montserrat',
      textTheme: lightTextTheme,
    );
  }

  static TextTheme darkTextTheme = const TextTheme(
      titleLarge: TextStyle(fontSize: 12, color: Colors.black),
      headlineSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xffFFFFFF)),
      displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      displayMedium: TextStyle(
          fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xffB68708)),
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700));

  static ThemeData dark() {
    return ThemeData(
        brightness: Brightness.dark,
        // fontFamily: 'Montserrat',
        textTheme: darkTextTheme);
  }
}
