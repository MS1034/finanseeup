import 'package:finanseeup/widgets/google_sign_in_button.dart';
import 'package:finanseeup/widgets/login_Form.dart';
import 'package:flutter/material.dart';
import 'package:finanseeup/consts/image_strings.dart';
import 'package:finanseeup/consts/text_strings.dart';
import 'package:finanseeup/screens/sign_up.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void showErrorMessage(String message) {
    // Tampilkan dialog dengan pesan error
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
          );
        });
  }

  String _errorMessage = "";

  void validateEmail(String val) {
    if (val.isEmpty) {
      // Validasi jika email kosong
      setState(() {
        _errorMessage = "Email tidak boleh kosong";
      });
    } else if (!EmailValidator.validate(val, true)) {
      // Validasi jika email tidak valid
      setState(() {
        _errorMessage = "Alamat Email tidak valid";
      });
    } else {
      setState(() {
        _errorMessage = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(ImageAssets.logo),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    TextStrings.signinTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 15.0),
                  Text(TextStrings.signinBody,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              LogInForm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TextStrings.noAccount,
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      TextStrings.signUp,
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
              Container(width: double.infinity,child: GoogleSignInButton(onPressed: () => {})),
            ],
          ),
        ),
      ),
    );
    // return SafeArea(
    //   child: Scaffold(
    //     resizeToAvoidBottomInset: false,
    //     backgroundColor: Colors.grey,
    //     body: ListView(
    //       padding: const EdgeInsets.fromLTRB(0, 400, 0, 0),
    //       shrinkWrap: true,
    //       reverse: true,
    //       children: [
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             Stack(
    //               children: [
    //                 Container(
    //                   height: 535,
    //                   width: double.infinity,
    //                   decoration: BoxDecoration(
    //                     color: Theme.of(context).scaffoldBackgroundColor,
    //                     // color: Color(0xffffffff),
    //                     borderRadius: const BorderRadius.only(
    //                       topLeft: Radius.circular(40),
    //                       topRight: Radius.circular(40),
    //                     ),
    //                   ),
    //                   child: const Padding(
    //                     padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.fromLTRB(15, 0, 0, 20),
    //
    //                           child: LogInForm(),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //                 Transform.translate(
    //                   offset: const Offset(0, -280),
    //                   child: Image.asset(
    //                     ImageAssets.login,
    //                     scale: 0.8,
    //                     width: double.infinity,
    //                   ),
    //                 ),
    //               ],
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
