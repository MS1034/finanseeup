import 'dart:async';

import 'package:finanseeup/controllers/timer_controller.dart';
import 'package:finanseeup/views/account_success.dart';
import 'package:finanseeup/widgets/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication_repository.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();
  final  timer = Get.put(TimerController());

  /// Send Email Whenever Verify Screen appears & Set Timer for auto redirect.
  @override
  void onInit() {
    super.onInit();
    // Send Email Verification link
    sendVerificationEmail();
    // setTimerForAutoRedirect();
  }

  /// Send Email Verification Link
  sendVerificationEmail() async {
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null && currentUser.emailVerified) {
        throw Exception("Email already Verified");
      }

      await AuthenticationRepository.instance.sendEmailVerification();
      timer.startTimer();
      AppLoaders.successSnackBar(
        title: 'Email Verification Sent',
        message: 'Check your email for the verification link.',
      );
    } catch (e) {
      AppLoaders.errorSnackBar(
        title: 'Oh Snap!',
        message: e.toString(),
      );
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Get.to(() => const AccountSuccess(
              // image: AppImages.verifiedAnimation,
              // title: AppTexts.accountCreatedTitle,
              // subtitle: AppTexts.accountCreatedSubtitle,
              // onPressed: AuthenticationRepository.instance.screenRedirect()
              ));
        }
      },
    );
  }

// Manually Check if Email Verified
  checkEmailVerificationStatus() async {
    print("YES");

    await FirebaseAuth.instance.currentUser?.reload();
    final currentUser = FirebaseAuth.instance.currentUser;
    print(currentUser?.emailVerified == true);

    if (currentUser != null && currentUser.emailVerified) {
      if (kDebugMode) {
        print("YES");
      }
      Get.to(() => const AccountSuccess(
          // image: AppImages.verifiedAnimation,
          // title: AppTexts.accountCreatedTitle,
          // subtitle: AppTexts.accountCreatedSubtitle,
          // onPressed: AuthenticationRepository.instance.screenRedirect()
          ));
    }
  }
}
