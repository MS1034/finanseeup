import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/consts/text_strings.dart';
import 'package:finanseeup/widgets/password_field.dart';
import 'package:flutter/material.dart';

import '../utils/validators/validations.dart';
import 'email_field.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  bool _isChecked = false; // Replace false with your initial value
  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: EmailField(
                    controller: _emailController,
                    labelText: AppTexts.emailLabel,
                    hintText: AppTexts.emailHint,
                    validator: (value) => AppValidations.validateEmail(value),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: PasswordField(
                  controller: _emailController,
                  labelText: AppTexts.passwordLabel,
                  hintText: AppTexts.passwordHint,
                  validator: (value) => AppValidations.validatePassword(value),
                )),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(AppTexts.rememberMe,
                      style: TextStyle(fontSize: 12, color: Colors.grey))
                ],
              ),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(150, 5)), // Set the minimum size
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
                    onPressed: () {},
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
    );
  }
}
