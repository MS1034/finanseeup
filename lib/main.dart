import 'package:finanseeup/screens/home.dart';
import 'package:finanseeup/screens/on_boarding.dart';
import 'package:finanseeup/screens/splash.dart';
import 'package:finanseeup/screens/welcome.dart';
import 'package:finanseeup/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Finansee Up',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home:  OnBoardingScreen(),
    );
  }
}


