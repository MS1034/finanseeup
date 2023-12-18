import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:finanseeup/views/main_page.dart';
import 'package:finanseeup/views/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final title;

  @override
  State<HomeView> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout), // Cross icon
                onPressed: () => {
                  // GetStorage().erase();
                  AuthenticationRepository.instance.logout()
                },
              ),
            ],
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  // icon: Icon(Icons.account_balance_wallet),
                  text: "Accounts",
                ),
                Tab(
                  text: "Budget and Goals",

                ),
              ],
            ),
          ),
          body:
          const TabBarView(
            children: <Widget>[
              MainPage(),

              Center(
                child: Text("It's rainy here"),
                //Add Buget and Goals
              ),
            ],
          ),
          floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.edit),
                  label: "New Record",
                  shape: const CircleBorder(),
                  onTap: () => Get.to(const RecordView(initialTabNumber: 1,))),
              SpeedDialChild(
                  child: const Icon(Icons.swap_horiz_outlined),

                  label: "Transfer",
                  shape: const CircleBorder(),
                  onTap: () => Get.to(const RecordView(initialTabNumber: 3,))),

              
            ],
          )),
    );
  }
}
