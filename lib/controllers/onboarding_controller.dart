import 'package:finanseeup/Views/on_boarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../utils/consts/image_strings.dart';
import '../utils/consts/text_strings.dart';
import '../models/on_boarding_model.dart';
import '../views/sign_in.dart';
import '../views/welcome.dart';
import '../widgets/on_boarding_page.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();
  final liquidController = LiquidController();
  final storage = GetStorage();

  late RxInt currentPage = 0.obs;
  final pages = [
    OnBoardingPage(
      model: OnBoardingModel(
        image: AppImages.onBoarding1,
        title: AppTexts.onBoardingTitle1,
        subTitle: AppTexts.onBoardingSubTitle1,
      ),
    ),
    OnBoardingPage(
      model: OnBoardingModel(
        image: AppImages.onBoarding2,
        title: AppTexts.onBoardingTitle2,
        subTitle: AppTexts.onBoardingSubTitle2,
      ),
    ),
    // OnBoardingPage(
    //   model: OnBoardingModel(
    //       image: ImageAssets.onBoarding3,
    //       title: TextStrings.onBoardingTitle3,
    //       subTitle: TextStrings.onBoardingSubTitle3,
    //       ),
    // ),
    const Welcome(),
  ];

  int get activePageIndex => currentPage.value;

  onPageChangeCallback(int activePageIndex) {
    currentPage.value = activePageIndex;

  }
}
