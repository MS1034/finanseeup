import 'package:finanseeup/Views/sign_in.dart';
import 'package:finanseeup/controllers/forget_password_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/sizes.dart';
import '../utils/consts/text_strings.dart';
import '../utils/helpers/colors.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key, required this.email});

  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, actions: [
        IconButton(
            onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
      ]),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: const AssetImage(AppImages.resetPassword),
              width: AppHelperFunctions.screenWidth() * 0.8,
            ),
            Text(
              email ?? "No Email",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            /// Title & Subtitle
            Text(
              AppTexts.changeYourPasswordTitle,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            Text(
              AppTexts.changeYourPasswordSubtitle,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            /// Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(const LoginView());
                },
                // Replace YourNextScreen with the actual next screen widget.
                child: const Text(AppTexts.appContinue),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => TextButton(
                  onPressed:
                      ForgetPasswordController.instance.timer.EnableButton.value
                          ? () => ForgetPasswordController.instance
                              .resendPasswordResetEmail()
                          : null,
                  child: Text(
                    '${AppTexts.resendEmail}${ForgetPasswordController.instance.timer.timerValue > 0 ? " ${ForgetPasswordController.instance.timer.timerValue} seconds" : ""}',
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
