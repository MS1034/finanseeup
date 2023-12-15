import 'package:finanseeup/views/sign_in.dart';
import 'package:finanseeup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/consts/text_strings.dart';
import '../widgets/google_sign_in_button.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              Text(
                AppTexts.signupBody,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 30,
              ),
              SignupForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppTexts.haveAccount,
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  TextButton(
                    onPressed: () => {Get.offAll(const LoginView())},
                    child: const Text(
                      AppTexts.signIn,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Text(
                "OR",
                style: Theme.of(context).textTheme.bodySmall,
                softWrap: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: const GoogleSignInButton(
                    text: AppTexts.signupWithGoogle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
