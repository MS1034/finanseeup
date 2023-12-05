import 'package:finanseeup/widgets/password_field.dart';
import 'package:flutter/material.dart';

import '../consts/text_strings.dart';
import 'email_field.dart';

class SignupForm extends StatefulWidget {
  SignupForm({Key? key}) : super(key: key);


  bool _isChecked = false; // Replace false with your initial value
  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _reEnterPasswordController = TextEditingController();

  bool _isChecked = false; // Replace false with your initial value
  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: TextStrings.labelFirstName,
                      hintText: TextStrings.HintFirstName,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(

                        vertical: 0,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: TextStrings.labelLastName,
                      hintText: TextStrings.HintLastName,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding: EdgeInsets.symmetric(

                        vertical: 0,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
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
                      controller: _passwordController,
                      labelText: TextStrings.passwordLabel,
                      hintText: TextStrings.passwordHint),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: PasswordField(
                      controller: _reEnterPasswordController,
                      labelText: TextStrings.reEnterPasswordLabel,
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

          ],
        ),
      ),
    );
  }
}
