import 'package:finanseeup/controllers/email_verification_controller.dart';
import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/sizes.dart';
import '../utils/consts/text_strings.dart';
import '../utils/helpers/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';


class VerifyEmailView extends StatelessWidget {
  const VerifyEmailView({super.key,this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
            AuthenticationRepository.instance.logout();
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
                email?? '',
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
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text(AppTexts.appContinue),
                ),
              ),
              const SizedBox(height: AppSizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    controller.sendVerificationEmail();
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
