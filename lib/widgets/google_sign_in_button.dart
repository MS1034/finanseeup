import 'package:flutter/material.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/consts/text_strings.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const GoogleSignInButton({Key? key, required this.onPressed,required this.text}) : super(key: key);

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
          Image.asset(AppImages.googleLogo,height: 24.0),
          SizedBox(width: 10.0),
          Text(text),
        ],
      ),
    );
  }
}
