import 'package:finanseeup/controllers/account_controller.dart';
import 'package:finanseeup/views/accounts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'new_account_form.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountController());

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('List of Accounts',
                            style: Theme.of(context).textTheme.titleSmall),
                        const Spacer(),
                        // IconButton for List of Accounts
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {
                            Get.to(AccountsView(onTapCallback: (account) {
                              // Do something with the selected account, e.g., navigate to another screen
                              Get.to(AddAccountView(
                                controller: controller,
                                account: account,
                              ));
                            }));
                          },
                        ),
                      ],
                    ),
                  ),

                  Obx(
                    () => GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.6,
                      ),
                      itemCount: controller.allAccounts.value.length,
                      // Use the length of the accounts list
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final account = controller.allAccounts.value[index];
                        return AccountPill(
                          accountName: account.accountName ?? "",
                          cash: account.amount ?? 0,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 4.0),

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          Get.to(AddAccountView(controller: controller));
                        },
                        icon: const Icon(Icons.account_balance),
                        // Add the desired icon
                        label: const Text('Add New'),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Implement logic for Records
                        },
                        icon: const Icon(Icons.history), // Add the desired icon
                        label: const Text('Records'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class AccountPill extends StatelessWidget {
  final String accountName;
  final double cash;

  const AccountPill({
    super.key,
    required this.accountName,
    required this.cash,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              accountName,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4.0), // Adjust the spacing as needed
            Text(
              '$cash',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
