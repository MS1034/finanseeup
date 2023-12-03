import 'package:finanseeup/consts/image_strings.dart';
import 'package:finanseeup/consts/text_strings.dart';
import 'package:finanseeup/widgets/password_field.dart';
import 'package:flutter/material.dart';

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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: <Widget>[
            //     Stack(
            //       alignment: Alignment.center,
            //       children: [
            //         Opacity(
            //           opacity: 0.12,
            //           child: Container(
            //             width: 40,
            //             height: 40,
            //             decoration: const BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: Colors.tealAccent,
            //             ),
            //           ),
            //         ),
            //         const Icon(
            //           Icons.lock,
            //           color: Colors.teal,
            //           size: 24,
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       width: 16.0,
            //     ),
            //     Text(
            //       TextStrings.login,
            //       style: Theme.of(context).textTheme.titleLarge,
            //     ),
            //   ],
            // ),

            // const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: EmailField(
                    controller: _emailController,
                    labelText: TextStrings.emailLabel,
                    hintText: TextStrings.emailHint,
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
                      labelText: TextStrings.passwordLabel,
                      hintText: TextStrings.passwordHint),
                ),
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
                  const Text(TextStrings.rememberMe,
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
                  TextStrings.forgetPassword,
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
                        TextStrings.signin,
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
