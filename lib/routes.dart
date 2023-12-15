import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finanseeup/views/home.dart';
import 'package:finanseeup/views/verify_email.dart';
import 'package:finanseeup/views/welcome.dart';
import 'package:finanseeup/views/on_boarding.dart';



class AppRoutes extends GetMiddleware {
  static Widget redirectRoute() {
    final user= FirebaseAuth.instance.currentUser;
    if (user!=null) {
      // User is logged in, redirect to desired page
      if (user.emailVerified) {
        return const HomeView(title: "yes",);

      } else {
        return const VerifyEmailView();
      }
    }
    else {
      final deviceStorage = GetStorage();
      return deviceStorage.read("IsFirstTime")==false? const Welcome() : const OnBoardingView();

    }
  }
}
