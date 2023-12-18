import 'package:flutter/material.dart';

import 'consts/sizes.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal, brightness: Brightness.dark),
    fontFamily: "Poppins",
    textTheme: TextTheme(
      bodySmall:
          TextStyle(fontSize: AppSizes.fontSizeXs, color: Colors.grey.shade400),
      titleMedium: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      headlineMedium: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      headlineSmall:
          const TextStyle(fontWeight: FontWeight.w700, fontSize: AppSizes.fontSizeXL),
    ),
    buttonTheme: const ButtonThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
        primarySwatch: Colors.teal, brightness: Brightness.light),
    textTheme: TextTheme(
      bodySmall:
          TextStyle(fontSize: AppSizes.fontSizeXs, color: Colors.grey.shade400),
      headlineMedium: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      titleMedium: const TextStyle(
        fontWeight: FontWeight.w700,
      ),
      titleLarge: const TextStyle(
        fontWeight: FontWeight.w900,
      ),
      headlineSmall:
          const TextStyle(fontWeight: FontWeight.w900, fontSize: AppSizes.fontSizeXL),
    ),
    buttonTheme: const ButtonThemeData(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  );
}
