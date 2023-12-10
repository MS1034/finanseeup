import 'package:flutter/material.dart';

import 'consts/sizes.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(


    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
        brightness: Brightness.dark
    ),
    fontFamily: "Poppins",
    textTheme:  TextTheme(
      bodySmall:TextStyle(
        fontSize: AppSizes.fontSizeXs,
        color: Colors.grey.shade400
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w900,
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w900,
      ),
    ),
    // textTheme: const TextTheme(
    //   titleMedium: TextStyle(fontWeight: FontWeight.w900),
    // ),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    // primaryColor: Colors.teal,
    fontFamily: "Poppins",
    scaffoldBackgroundColor: Colors.white,


    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.teal,
        brightness: Brightness.light
    ),
    textTheme:  TextTheme(
      bodySmall:TextStyle(
        fontSize: AppSizes.fontSizeXs,
          color: Colors.grey.shade400
      ),
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w900,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}
