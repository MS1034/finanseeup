import 'package:finanseeup/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:get/get.dart';

class GoogleSignInButton extends StatelessWidget {
  // final VoidCallback onPressed;
  final String text;

  const GoogleSignInButton({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return ElevatedButton(
      onPressed: ()=>{controller.googleSign()},
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryIconTheme.color,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(AppImages.googleLogo,height: 24.0),
          const SizedBox(width: 10.0),
          Text(text),
        ],
      ),
    );
  }
}
