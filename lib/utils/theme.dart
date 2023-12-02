import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(
      0xFF2196F3, // Primary color
      <int, Color>{
        50: Color(0xFFE3F2FD),
        100: Color(0xFFBBDEFB),
        200: Color(0xFF90CAF9),
        300: Color(0xFF64B5F6),
        400: Color(0xFF2196f3),
        500: Color(0xFF2196F3),
        600: Color(0xFF1E88E5),
        700: Color(0xFF1976D2),
        800: Color(0xFF1565C0),
        900: Color(0xFF304fff),

      },
    ),
    fontFamily: "Poppins",
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.cyan,
    // primarySwatch: const MaterialColor(
    //   0xFF2196F3, // Primary color for dark mode
    //   <int, Color>{
    //     50: Color(0xFFE3F2FD),
    //     100: Color(0xFFBBDEFB),
    //     200: Color(0xFF90CAF9),
    //     300: Color(0xFF64B5F6),
    //     400: Color(0xFF42A5F5),
    //     500: Color(0xFF2196F3),
    //     600: Color(0xFF1E88E5),
    //     700: Color(0xFF1976D2),
    //     800: Color(0xFF1565C0),
    //     900: Color(0xFF0D47A1),
    //   },
    // ),
    fontFamily: "Poppins",
  );
}
