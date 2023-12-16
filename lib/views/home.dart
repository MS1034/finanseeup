import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget
{
  const HomeView({super.key, required this.title});
  final title;
  @override
  State<HomeView> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<HomeView>
{
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.account_balance_wallet),
              ),
              Tab(
                icon: Icon(Icons.beach_access_sharp),
              ),

            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            Center(

              child: ElevatedButton(onPressed: ()=>{
                // GetStorage().erase();
                AuthenticationRepository.instance.logout()
                }, child: const Text("Logout")),
            ),
            const Center(
              child: Text("It's rainy here"),
            ),
          ],
        ),
      ),
    );

  }

}

