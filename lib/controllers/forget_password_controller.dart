import 'package:finanseeup/controllers/timer_controller.dart';
import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';

import 'package:finanseeup/utils/popups/full_screen_loader.dart'
    show AppFullScreenLoader;
import 'package:finanseeup/views/reset_password.dart';
import 'package:finanseeup/widgets/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../utils/network manager/network_manager.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  TextEditingController get emailController => _emailController;

  final TextEditingController _emailController = TextEditingController();

  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();



  // Get.put(NetworkManager());
  final NetworkManager _networkManager = Get.put(NetworkManager());
  final  timer = Get.put(TimerController());

  sendPasswordResetEmail() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }
      if (!forgetPasswordFormKey.currentState!.validate()) {
        AppFullScreenLoader.stoploading();
        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(_emailController.text.trim());



      AppFullScreenLoader.stoploading();

      timer.startTimer();

      AppLoaders.successSnackBar(
          title: 'Congratulations', message: 'Email Link send to reset your password!');

      Get.to(ResetPasswordView(
        email: _emailController.text.trim(),
      ));
    } catch (e) {
      AppFullScreenLoader.stoploading();
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  resendPasswordResetEmail() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }

      await AuthenticationRepository.instance
          .sendPasswordResetEmail(_emailController.text.trim());



      AppFullScreenLoader.stoploading();

      timer.startTimer();

      AppLoaders.successSnackBar(
          title: 'Congratulations', message: 'Email Link send to reset your password!');

    } catch (e) {
      AppFullScreenLoader.stoploading();
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }
}
