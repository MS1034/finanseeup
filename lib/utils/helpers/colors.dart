import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../theme.dart';

class AppHelperFunctions {
  static Color bgColor() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark
        ? AppTheme.darkTheme.colorScheme.background
        : AppTheme.lightTheme.colorScheme.background;

  }
  static Color inverseBgColor() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark
        ? AppTheme.darkTheme.colorScheme.inversePrimary
        : AppTheme.lightTheme.colorScheme.inversePrimary;

  }
  static Color textColor() {
    return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark
        ? AppTheme.lightTheme.colorScheme.background
        : AppTheme.darkTheme.colorScheme.background;

  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width ;
  }

}