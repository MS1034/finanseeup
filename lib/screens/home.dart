import 'package:flutter/material.dart';
class HomePage extends StatefulWidget
{
  const HomePage({super.key, required this.title});
  final title;
  @override
  State<HomePage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<HomePage>
{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text("Home"),),
    body: const Text("Hello"),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        setState(() {
        });
      },
      child: const Icon(Icons.add),
    ),
  );
  }

}

