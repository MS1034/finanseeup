
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanseeup/Views/login.dart';
import 'package:finanseeup/Views/on_boarding.dart';
import 'package:finanseeup/controllers/signin_controller.dart';
import 'package:finanseeup/models/user_model.dart';
import 'package:finanseeup/views/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../exceptions/app_exceptions.dart';


class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Called from main. dart on opp launch

  /*                                      Email and Password                          */
  Future<void> saveUserRecord(UserModel user) async {
    try {
      return await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FormatException catch (_) {
      throw  AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    }
    catch(e)
    {
      throw 'Something went wrong. Please try again.';
    }
  }



}