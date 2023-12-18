import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  final int resendDuration = 60; // Change this to your desired timer duration
  final RxInt _timerValue = RxInt(0);
  Timer? _timer;

  // Get current timer value
  int get timerValue => _timerValue.value;

   RxBool enableButton  = false.obs;

  RxBool get EnableButton => enableButton;

  // Start timer
  void startTimer() {

    _timer?.cancel();
    enableButton = false.obs;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerValue.value = resendDuration - timer.tick;
      if (_timerValue.value == 0) {
        cancelTimer();

        // Enable resend button in ForgetPasswordController
      }
    });
  }

  // Cancel timer
  void cancelTimer() {
    _timer?.cancel();
    enableButton = true.obs;
  }
}
