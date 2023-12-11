import 'package:finanseeup/Views/login.dart';
import 'package:finanseeup/Views/on_boarding.dart';
import 'package:finanseeup/controllers/email_verification_controller.dart';
import 'package:finanseeup/controllers/signin_controller.dart';
import 'package:finanseeup/views/home.dart';
import 'package:finanseeup/views/verify_email.dart';
import 'package:finanseeup/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../exceptions/app_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Called from main. dart on opp launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    if(kDebugMode)
      {
        print("object is screen");
      }
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const HomePage(title: "title"));
      } else {
        Get.offAll(() => VerifyEmailView(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull("IsFirstTime", true);
    // deviceStorage.read("IsFirstTime")==false?Get.to(()=> const Welcome()):Get.to( const OnBoardingView());
    }
  }

  @override
  void onInit() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /*                                      Email and Password                          */
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }


  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.to(()=>const LoginView());
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }

  /// Email Verification - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
