import 'package:finanseeup/controllers/transaction_controller.dart';
import 'package:finanseeup/models/enum_account_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Account> accounts = [
      Account(id:"123456",accountName: "accountName", type: AccountType.Cash, currency: "PKR", color: Colors.red),
      Account(id:"123456",accountName: "accountName1", type: AccountType.Cash, currency: "PKR", color: Colors.yellow),
      Account(id:"123456",accountName: "accountName3", type: AccountType.Cash, currency: "PKR"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return ListTile(
            title: Text(account.accountName!),
            subtitle: Text(account.type?.name ?? ""),

            leading: CircleAvatar(
              backgroundColor: account.color ?? Colors.black,
            ),
            onTap: () {
              Get.back(result: account); // Return the selected account to the previous screen
            },
          );
        },
      ),
    );
  }
}
