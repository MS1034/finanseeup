import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:finanseeup/widgets/on_boarding_page.dart';
import 'package:flutter/material.dart';

import '../consts/image_strings.dart';
import '../consts/text_strings.dart';

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
                    OutlinedButton(onPressed: () => {}, child: Text("Log In")),
                    ElevatedButton(onPressed: ()=>{}, child: Text("Sign Up"))
                  ],
                )
              ],
            ),
          )
    );
  }
}
