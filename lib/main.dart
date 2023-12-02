import 'package:finanseeup/screens/home.dart';
import 'package:finanseeup/screens/splash.dart';
import 'package:finanseeup/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(title: 'Forget Password Page'),
    );
  }
}


