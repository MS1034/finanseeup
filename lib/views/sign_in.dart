import 'package:finanseeup/widgets/google_sign_in_button.dart';
import 'package:finanseeup/widgets/login_Form.dart';
import 'package:flutter/material.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/consts/text_strings.dart';
import 'package:finanseeup/views/sign_up.dart';
import 'package:get/get.dart';


class LoginView extends StatelessWidget {


   const LoginView({super.key});

  // final LoginModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    height: 150,
                    image: AssetImage(AppImages.logo),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    AppTexts.signinTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 15.0),
                  Text(AppTexts.signinBody,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const LogInForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppTexts.noAccount,
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  TextButton(
                    onPressed: () => Get.to(() =>  SignUpView()),
                    child: const Text(
                      AppTexts.signUp,
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
              const SizedBox(width: double.infinity,child: GoogleSignInButton(text: AppTexts.signinWithGoogle,)),
            ],
          ),
        ),
      ),
    );

  }
}
