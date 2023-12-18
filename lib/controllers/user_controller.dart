import 'package:finanseeup/data/repositories/user_repository.dart';
import 'package:finanseeup/models/user_model.dart';
import 'package:finanseeup/widgets/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();
  final userRepository = Get.put(UserRepository());




  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      if (userCredentials == null) {
        // Handle the case when userCredentials is null
        return;
      }

      // Convert Name to First and Last Name
      final nameParts =
          UserModel.nameParts(userCredentials.user!.displayName ?? '');

      // Map Data
      final user = UserModel(
        id: userCredentials.user!.uid,
        firstName: nameParts[0],
        lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
        email: userCredentials.user!.email ?? '',
        profilePicture: userCredentials.user!.photoURL ?? '',
      );

      await userRepository.saveUserRecord(user);
    } catch (e) {
    //   AppLoaders.warningSnackBar(
    //       title: 'Data not saved',
    //       message:
    //           'Something went wrong while saving your information. You can re-save your data in your Profile');
    // }
    AppLoaders.warningSnackBar(
        title: 'Data not saved',
        message:
        '$e');
  }
  }

  UserController();
}
