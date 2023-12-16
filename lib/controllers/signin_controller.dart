import 'package:finanseeup/controllers/user_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/repositories/authentication_repository.dart';
import '../utils/consts/image_strings.dart';
import '../utils/network manager/network_manager.dart';
import '../utils/popups/full_screen_loader.dart';
import '../widgets/loaders.dart';

class SignInController extends GetxController {
  static SignInController get instance => Get.find();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  final rememberMe = true.obs;
  final hidePassword = true.obs;
  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final storage = GetStorage();

  final NetworkManager _networkManager = Get.put(NetworkManager());
  final userController = Get.put(UserController());

  SignInController() {}

  @override
  void onReady() {
    if(kDebugMode)
      {
        print("hello Subhan");
        print(storage.read("RememberMeEmail") ?? "No Email");
        print(storage.read("RememberMePassword") ?? "No Password");
      }
  }

  Future<void> emailPasswordSign() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }
      if (!signInFormKey.currentState!.validate()) {
        AppFullScreenLoader.stoploading();
        return;
      }



      await AuthenticationRepository.instance.loginWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());

      if (rememberMe.value) {
        storage.write("RememberMeEmail", emailController.text.trim());
        storage.write("RememberMePassword", passwordController.text.trim());
      }

      AppFullScreenLoader.stoploading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullScreenLoader.stoploading();
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  Future<void> googleSign() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
          "Logging In with Google", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }

      final userCredentials =
          await AuthenticationRepository.instance.loginWithGoogle();

      await userController.saveUserRecord(userCredentials);

      AppFullScreenLoader.stoploading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      AppFullScreenLoader.stoploading();
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  @override
  void onInit() {
    _emailController.text = storage.read("RememberMeEmail") ?? "";
    _passwordController.text = storage.read("RememberMePassword") ?? "";

    super.onInit();
  }
}
