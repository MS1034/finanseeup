import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/sizes.dart';

class AppLoaders {
  static warningSnackBar({
    required String title,
    required String message,
    bool isDismissible = true,
    int duration = 3,
  }) {
    Get.snackbar(
      title,
      '',
      isDismissible: isDismissible,
      shouldIconPulse: true,
      colorText: Colors.grey.shade100,
      backgroundColor: Colors.orange.shade400,
      duration: Duration(seconds: duration),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(10.0),
      icon: const Icon(Icons.warning, color: Colors.white)
        ,messageText: Text(
      message,
      style: const TextStyle(
        fontSize: AppSizes.fontSizeXs, // Adjust the font size as needed
      ),
    ),
    );
  }

  static errorSnackBar({
    required String title,
    required String message,
    bool isDismissible = true,
    int duration = 3,
  }) {
    Get.snackbar(
        title,
        "",
        isDismissible: isDismissible,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10.0),
        icon: const Icon(Icons.error, color: Colors.white)
      ,messageText: Text(
      message,
      style: const TextStyle(
        fontSize: AppSizes.fontSizeXs, // Adjust the font size as needed
      ),
    ),
    );
  }

  static successSnackBar({
    required String title,
    required String message,
    bool isDismissible = true,
    int duration = 3,
  }) {
    Get.snackbar(
        title,
        "",
        isDismissible: isDismissible,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: Colors.greenAccent.shade700,
        duration: Duration(seconds: duration),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10.0),
        icon: const Icon(Icons.check, color: Colors.white)
      ,messageText: Text(
      message,
      style: const TextStyle(
        fontSize: AppSizes.fontSizeXs, // Adjust the font size as needed
      ),
    ),
    );
  }
}
