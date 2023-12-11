import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:finanseeup/data/repositories/user_repository.dart';
import 'package:finanseeup/models/user_model.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';

// import 'package:finanseeup/utils/network%20manager/network_manager.dart';
import 'package:finanseeup/utils/popups/full_screen_loader.dart';
import 'package:finanseeup/views/verify_email.dart';
import 'package:finanseeup/widgets/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../utils/network manager/network_manager.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  TextEditingController get firstNameController => _firstNameController;

  TextEditingController get lastNameController => _lastNameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get reEnterPasswordController =>
      _reEnterPasswordController;

  // late SignUpModel _model;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
  TextEditingController();

  final privacypolicy = true.obs;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Get.put(NetworkManager());
  final NetworkManager _networkManager = Get.put(NetworkManager());

  Future<void> signUp() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }
      if (!signupFormKey.currentState!.validate()) {
        AppFullScreenLoader.stoploading();
        return;
      }

      if (!privacypolicy.value) {
        AppFullScreenLoader.stoploading();

        AppLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
            "In order to create account you ,must have to accept the Terms and Conditions.");
        return;
      }

      final userCredentials = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());

      final newUser = UserModel(
          id: userCredentials.user!.uid,
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      userRepository.saveUserRecord(newUser);
      AppFullScreenLoader.stoploading();

      AppLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your account has been created!');

      Get.offAll( VerifyEmailView(email: _emailController.text.trim(),));
    }

    catch (e) {
      AppFullScreenLoader.stoploading();
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }
}