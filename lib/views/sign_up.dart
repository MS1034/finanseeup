import 'package:finanseeup/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/text_strings.dart';
import '../controllers/login_controller.dart';
import '../models/signup_model.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/login_Form.dart';

class SignUpView extends StatelessWidget {
   SignUpView({super.key,required this.model});

  final SignUpModel model;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top:60 , left: 15, right: 15, bottom: 15),
          child: Column(
            children: [

              Text(
                TextStrings.signupBody,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 30,
              ),
              SignupForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TextStrings.haveAccount,
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  TextButton(
                    onPressed: ()=> {Get.to( SignInController().getView())},
                    child: const Text(
                      TextStrings.signIn,
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
              SizedBox(
                height: 10,
              ),
              Container(width: double.infinity,child: GoogleSignInButton(onPressed: () => {},text: TextStrings.signupWithGoogle,)),
            ],
          ),
        ),
      ),
    );
  }
}
