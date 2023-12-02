import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,

    primarySwatch: Colors.teal
    ,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.tealAccent),
          side: MaterialStateProperty.all(BorderSide(color: Colors.tealAccent)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
      ),

    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.tealAccent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

      ),
    ),
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
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.tealAccent),
      ),
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontWeight: FontWeight.w900), // Adjust the fontWeight as needed
      // You can customize other text styles here...
    ),
  );
}
