import 'package:finanseeup/Views/login.dart';
import 'package:finanseeup/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/sizes.dart';
import '../utils/consts/text_strings.dart';
import '../utils/helpers/colors.dart';

class AccountSuccess extends StatelessWidget {
  const AccountSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
              Image(
                image: const AssetImage(AppImages.accountCreatedIllustration),
                width: AppHelperFunctions.screenWidth(),
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Title & Subtitle
              Text(
                AppTexts.accountCreatedTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),

              Text(
                AppTexts.accountCreatedSubtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const LoginView()),
                  // Replace YourNextScreen with the actual next screen widget.
                  child: const Text(AppTexts.appContinue),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              // Add any additional widgets or buttons as needed
            ],
          ),
        ),
      ),
    );
  }
}
