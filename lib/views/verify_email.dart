import 'package:finanseeup/Views/login.dart';
import 'package:finanseeup/views/account_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/sizes.dart';
import '../utils/consts/text_strings.dart';
import '../utils/helpers/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';


class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginView()),
              );
            },
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.defaultSpace),
          child: Column(
            children: [
              /// Image
               SvgPicture.asset(
                  AppImages.deliveredEmailIllustration,
            width: AppHelperFunctions.screenWidth() ,

                ),
                // image: const AssetImage(AppImages.deliveredEmailIllustration),
              const SizedBox(height: AppSizes.spaceBtwSections),
              /// Title & Subtitle
              Text(
                AppTexts.confirmEmailTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.supportEmail,
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              Text(
                AppTexts.confirmEmailSubtitle,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: AppSizes.spaceBtwSections),
              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const AccountSuccess()),
                  child: const Text(AppTexts.appContinue),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Handle button press
                  },
                  child: const Text(AppTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
