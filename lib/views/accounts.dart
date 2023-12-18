import 'package:finanseeup/controllers/account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/account.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key, required this.onTapCallback});
  final Function(Account) onTapCallback;

  @override
  Widget build(BuildContext context) {
    final controller = AccountController.instance;
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
      body: Obx(
        () => ListView.builder(
          itemCount: controller.accounts.length,
          itemBuilder: (context, index) {
            final account = controller.accounts.value[index];
            return ListTile(
              title: Text(account.accountName!),
              subtitle: Text(account.type ?? ""),
              leading: CircleAvatar(
                backgroundColor: account.color ?? Colors.black,
              ),
              onTap: () {
                print(account);

                onTapCallback(account);
                // Return the selected account to the previous screen
              },
            );
          },
        ),
      ),
    );
  }
}
