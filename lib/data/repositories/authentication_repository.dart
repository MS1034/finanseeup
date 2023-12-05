
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();

  /// Called from main. dart on opp launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();

    /// Function to Show Relevant Screen
  }
  screenRedirect() async {
    deviceStorage.writeIfNull(key, value)r
  }

  @override
  void onInit() {

  }
}