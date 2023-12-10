import 'package:finanseeup/controllers/onboarding_controller.dart';
import 'package:finanseeup/models/on_boarding_model.dart';
import 'package:finanseeup/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/consts/text_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';

import '../utils/theme.dart';
import '../widgets/on_boarding_page.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  // final controller = LiquidController();
  final controller = Get.put(OnBoardingController());

  @override
  Widget build(BuildContext context) {
    // final controller= Get.put(OnBoardingController());



    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: controller.liquidController,
            pages: controller.pages,
            // slideIconWidget: const Icon(Icons.arrow_back_ios_new_sharp),
            // enableSideReveal: true,
            enableLoop:false,
            onPageChangeCallback: controller.onPageChangeCallback,


          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 60.0,
              child: Center(
                  child: Obx(() => AnimatedSmoothIndicator(
                        activeIndex: controller.activePageIndex,
                        count: 3,
                        effect: const WormEffect(
                          dotHeight: 3.0,
                          activeDotColor: Colors.teal,
                        ),
                      ))))
        ],
      ),
    );
  }
}
