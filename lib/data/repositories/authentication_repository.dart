import 'package:finanseeup/Views/sign_in.dart';
import 'package:finanseeup/views/home.dart';
import 'package:finanseeup/views/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    // screenRedirect();
  }

  screenRedirect() async {

    if(kDebugMode)
      {
        print("object is screen");
        print( _auth.currentUser);
        print("================================Subhna========================");

      }
    User? user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const HomeView(title: "title"));
      } else {
        Get.offAll(() => VerifyEmailView(email: _auth.currentUser?.email));
      }
    } else {
      deviceStorage.writeIfNull("IsFirstTime", true);
    // deviceStorage.read("IsFirstTime")==false?Get.to(()=> const Welcome()):Get.to( const OnBoardingView());
    }
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

  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
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

  Future<UserCredential> loginWithGoogle() async {
    try {
      // Trigger Google Sign-In
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a new credential
      final OAuthCredential credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with the credential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credentials);

      // Return the user credential
      return userCredential;

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
