import 'package:finanseeup/models/login_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../views/login.dart';

class SignInController extends GetxController {
  late LoginModel _model;
  late LoginView _view;

  SignInController() {
    _model = LoginModel();
    _view = LoginView(model: _model);
  }

  Widget getView() {
    return _view;
  }
  void signIn() {
    print("Signing in with:${_model.email}");
  }
}
