import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:finanseeup/consts/image_strings.dart';
import 'package:finanseeup/consts/color_strings.dart';
import 'package:finanseeup/consts/text_strings.dart';
import 'package:finanseeup/consts/size_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/theme.dart';
import '../widgets/on_boarding_page.dart';

class OnBoardingScreen extends StatefulWidget {
   const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final controller = LiquidController();

  int currentPage =0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme.background;

    final pages = [
      OnBoardingPage(
        model: OnBoardingModel(
            image: ImageAssets.onBoarding1,
            title: TextStrings.onBoardingTitle1,
            subTitle: TextStrings.onBoardingSubTitle1,
            height: size.height * 0.4,
            bgColor: color),
      ),
      OnBoardingPage(
        model: OnBoardingModel(
            image: ImageAssets.onBoarding2,
            title: TextStrings.onBoardingTitle2,
            subTitle: TextStrings.onBoardingSubTitle2,
            height: size.height * 0.4,
            bgColor: color),
      ),
      OnBoardingPage(
        model: OnBoardingModel(
            image: ImageAssets.onBoarding3,
            title: TextStrings.onBoardingTitle3,
            subTitle: TextStrings.onBoardingSubTitle3,
            height: size.height * 0.4,
            bgColor: color),
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            pages: pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios_new_sharp),
            enableSideReveal: true,
            onPageChangeCallback: onPageChangeCallback,
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 60.0,
            child: Builder(
              builder: (BuildContext context) {
                return Center(child:
                AnimatedSmoothIndicator(
                  activeIndex: currentPage,
                  count: 3,
                  effect: WormEffect(
                    dotHeight: 3.0,
                    activeDotColor: Colors.teal,
                  ),
                ));
              },
            ),
          )

        ],
      ),
    );
  }

  onPageChangeCallback(int activePageIndex) {
    setState(() {
      currentPage = activePageIndex;
    });
  }

}


