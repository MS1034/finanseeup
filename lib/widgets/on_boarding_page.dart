import 'package:flutter/material.dart';

import '../models/on_boarding_model.dart';

class OnBoardingPage extends StatelessWidget {
  final OnBoardingModel model;

  const OnBoardingPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(30.0),
      color: model.bgColor,
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
          // Text(
          //   model.counterText,
          //   style: TextStyle(fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
