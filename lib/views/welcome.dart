import 'package:finanseeup/controllers/login_controller.dart';
import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:finanseeup/views/on_boarding.dart';
import 'package:finanseeup/views/sign_up.dart';
import 'package:finanseeup/widgets/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/image_strings.dart';
import '../consts/text_strings.dart';
import '../controllers/signup_controller.dart';
import 'login.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context));
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme.background;
    final OnBoardingModel model = OnBoardingModel(
        image: ImageAssets.welcome,
        title: TextStrings.welcomeTitle,
        subTitle: TextStrings.welcomeSubTitle,
        bgColor: color,
        height: 0.45 * size.height);
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(model.image),
          ),
          Column(children: [
            Text(
              model.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(model.subTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () => {Get.to( SignInController().getView())}, child: Text("Log In")),
              ElevatedButton(onPressed: () => Get.to(() => SignUpController().getView()), child: Text("Sign Up"))
            ],
          )
        ],
      ),
    ));
  }
}
