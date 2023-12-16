import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:finanseeup/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/text_strings.dart';
import 'sign_in.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {

    final deviceStorage = GetStorage();

    final OnBoardingModel model = OnBoardingModel(
      image: AppImages.welcome,
      title: AppTexts.welcomeTitle,
      subTitle: AppTexts.welcomeSubTitle,
    );
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
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(model.subTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                  onPressed: () {
                    deviceStorage.write("IsFirstTime", false);
                    Get.to(() => LoginView());
                  },
                  child: Text("Log In")),
              ElevatedButton(
                  onPressed: () {
                    deviceStorage.write("IsFirstTime", false);
                    Get.to(() => SignUpView());
                  },
                  child: Text("Sign Up"))
            ],
          )
        ],
      ),
    ));
  }


}
