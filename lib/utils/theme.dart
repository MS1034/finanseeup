import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,

    primarySwatch: Colors.red,
    fontFamily: "Poppins",
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.w900),

    ),
  );


  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    primaryColor: Colors.teal,
    fontFamily: "Poppins",
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.w900), // Adjust the fontWeight as needed
      // You can customize other text styles here...
    ),
  );
}
