import 'package:flutter/material.dart';
import 'package:finanseeup/consts/image_srings.dart';
class SplashScreen extends StatelessWidget
{
  const SplashScreen({super.key, required this.title});
  final title;
  @override
  Widget build(BuildContext context)
  {
    return const Scaffold(
      body: Column(

        children: [

          Positioned(child: Image(image: AssetImage(logo), )),
          SizedBox(height: 20),

          Text(
            'Where Financial Freedom Takes Flight',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

        ],
      ),
    );
  }

}
