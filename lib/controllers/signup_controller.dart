import 'package:finanseeup/models/signup_model.dart';
import 'package:finanseeup/views/sign_up.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController {
  late SignUpModel _model;
  late SignUpView _view;

  SignUpController() {
    _model = SignUpModel();
    _view = SignUpView(model: _model);
  }

  Widget getView() {
    return _view;
  }
  void signUp() {
    print("Signing up with: ${_model.firstName}, ${_model.lastName}, ${_model.email}");
  }
}
