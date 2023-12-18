import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/animation_loader.dart';

class AppFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: AppHelperFunctions.bgColor(),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  static stoploading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
