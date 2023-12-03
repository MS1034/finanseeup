import 'package:flutter/material.dart';
import 'package:finanseeup/consts/image_strings.dart';
import 'package:finanseeup/consts/text_strings.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryIconTheme.color,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Image.asset(ImageAssets.googleLogo,height: 24.0),
          SizedBox(width: 10.0),
          Text(TextStrings.signinWithGoogle),
        ],
      ),
    );
  }
}
