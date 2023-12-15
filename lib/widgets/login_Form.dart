import 'package:finanseeup/utils/consts/text_strings.dart';
import 'package:finanseeup/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signin_controller.dart';
import '../utils/validators/validations.dart';
import 'email_field.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Form(
      key: controller.signInFormKey,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: EmailField(
                      controller: controller.emailController,
                      labelText: AppTexts.emailLabel,
                      hintText: AppTexts.emailHint,
                      validator: (value) => AppValidations.validateEmail(value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: PasswordField(
                    controller: controller.passwordController,
                    labelText: AppTexts.passwordLabel,
                    hintText: AppTexts.passwordHint,
                    validator: (value) =>
                        AppValidations.validatePassword(value),
                  )),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) {
                          controller.rememberMe.value =
                              !controller.rememberMe.value;
                        },
                      ),
                    ),
                    const Text(AppTexts.rememberMe,
                        style: TextStyle(fontSize: 12, color: Colors.grey))
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(150, 5)), // Set the minimum size
                  ),
                  child: const Text(
                    AppTexts.forgetPassword,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {controller.emailPasswordSign();},
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          AppTexts.signin,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     // Handle sign-in action
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.white,
              //     onPrimary: Colors.black,
              //     padding: EdgeInsets.symmetric(horizontal: 16.0),
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(ImageAssets.googleLogo, width: 24.0, height: 24.0),
              //       SizedBox(width: 10.0),
              //       Text(TextStrings.signinWithGoogle),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
