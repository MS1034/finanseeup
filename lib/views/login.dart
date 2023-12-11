import 'package:finanseeup/widgets/google_sign_in_button.dart';
import 'package:finanseeup/widgets/login_Form.dart';
import 'package:flutter/material.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/consts/text_strings.dart';
import 'package:finanseeup/views/sign_up.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/signup_controller.dart';
import '../models/login_model.dart';

class LoginView extends StatefulWidget {
   const LoginView({super.key});

  // final LoginModel model;
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
              SizedBox(
                height: 30,
              ),
              LogInForm(),
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
              SizedBox(
                height: 10,
              ),
              Container(width: double.infinity,child: GoogleSignInButton(onPressed: () => {},text: AppTexts.signinWithGoogle,)),
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
