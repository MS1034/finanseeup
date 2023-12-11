import 'package:finanseeup/models/login_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../views/login.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  late LoginModel _model;



  SignInController() {
    _model = LoginModel();
  }


  void signIn() {
    print("Signing in with:${_model.email}");
  }
}
