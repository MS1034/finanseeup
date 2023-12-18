import 'package:finanseeup/controllers/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/sizes.dart';
import '../utils/consts/text_strings.dart';
import '../utils/validators/validations.dart';
import '../widgets/email_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Headings
            Text(
              AppTexts.forgetPasswordTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
            Text(
              AppTexts.forgetPasswordSubTitle,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections * 2),

            Form(
              key: controller.forgetPasswordFormKey,
              child: Expanded(
                child: EmailField(
                  controller: controller.emailController,
                  labelText: AppTexts.emailLabel,
                  hintText: AppTexts.emailHint,
                  validator: (value) => AppValidations.validateEmail(value),
                ),
              ),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.sendPasswordResetEmail(),
                    child: const Text(AppTexts.submit)))
          ],
        ),
      ),
    );
  }
}
