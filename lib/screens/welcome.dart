import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:finanseeup/screens/on_boarding.dart';
import 'package:finanseeup/screens/sign_up.dart';
import 'package:finanseeup/widgets/on_boarding_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/image_strings.dart';
import '../consts/text_strings.dart';
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
                  onPressed: () => {Get.to(const Login())}, child: Text("Log In")),
              ElevatedButton(onPressed: () => {Get.to(const SignUp())}, child: Text("Sign Up"))
            ],
          )
        ],
      ),
    ));
  }
}
