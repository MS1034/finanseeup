import 'package:finanseeup/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/consts/text_strings.dart';
import '../controllers/signup_controller.dart';
import 'email_field.dart';
import 'package:finanseeup/utils/validators/validations.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Form(
      key: controller.signupFormKey,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          AppValidations.validateEmptyText(value),
                      controller: controller.firstNameController,
                      decoration: InputDecoration(
                        labelText: AppTexts.labelFirstName,
                        hintText: AppTexts.hintFirstName,
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                        ),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        //
                        prefixIcon: const Icon(Icons.person),
// Adjust the font size as needed
                        // Other text style properties
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextFormField(
                      validator: (value) =>
                          AppValidations.validateEmptyText(value),
                      controller: controller.lastNameController,
                      decoration: InputDecoration(
                        labelText: AppTexts.labelLastName,
                        hintText: AppTexts.hintLastName,

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                        ),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        // Adjust the font size as needed
                        prefixIcon: const Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
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
                        validator: (value) =>
                            AppValidations.validatePassword(value),
                        // validator: (value) => AppValidations.validatePassword(value),
                        labelText: AppTexts.passwordLabel,
                        hintText: AppTexts.passwordHint),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: PasswordField(
                        validator: (value) => AppValidations.validateMatch(
                            value, controller.passwordController.text),
                        controller: controller.reEnterPasswordController,
                        labelText: AppTexts.reEnterPasswordLabel,
                        hintText: AppTexts.passwordHint),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          value: controller.privacypolicy.value,
                          onChanged: (value) {
                            controller.privacypolicy.value =
                                !controller.privacypolicy.value;
                          },
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppTexts.iAgreeTo,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            TextSpan(
                              text: AppTexts.privacyPolicy,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .apply(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            TextSpan(
                              text: ' ${AppTexts.ofApp}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        // adjust this value to your desired width
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signUp(); // Call the signUp method here
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          AppTexts.signUp,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
