import 'package:finanseeup/controllers/transaction_controller.dart';
import 'package:finanseeup/models/model_category.dart';
import 'package:finanseeup/utils/helpers/colors.dart';
import 'package:finanseeup/views/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/account.dart';
import '../views/accounts.dart';
import '../views/categories.dart';

class RecordContainer extends StatelessWidget {
  const RecordContainer({super.key, required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    // Sample data, replace with your actual data
    double amount = 1234567891; // Replace with your actual amount
    final controller = TransactionController.instance;
    NumberFormat formatter = NumberFormat("#,###.00");
    final button = (number == 3)
        ? TextButton(
            onPressed: () async {
              final selectedAccount =
                  await Get.to<Account>(AccountsView(onTapCallback: (account) {
                // Do something with the selected account, e.g., navigate to another screen
                Get.back(result: account);
              }));

              if (selectedAccount != null) {
                TransactionController.instance
                    .setSelectedAccount2(selectedAccount);
              }
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              backgroundColor: AppHelperFunctions.bgColor(),

              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Makes the button square
              ), // Adjust the padding as needed
            ),
            child: Column(
              children: [
                Text("To Account",
                    style: Theme.of(context).textTheme.bodySmall),
                Obx(() => Text(
                    controller.getSelectedAccount2.value.accountName ??
                        "Not Selected",
                    style: Theme.of(context).textTheme.labelSmall)),
              ],
            ),
          )
        : TextButton(
            onPressed: () async {
              final selectedCategory =
                  await Get.to<CategoryModel>(const CategoriesView());
              if (selectedCategory != null) {
                TransactionController.instance.getSelectedCategory.value =
                    selectedCategory;
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  AppHelperFunctions.bgColor()),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // Makes the button square
                ),
              ),
            ),
            child: Column(
              children: [
                Text("Category", style: Theme.of(context).textTheme.bodySmall),
                Obx(
                  () => Text(
                      controller.getSelectedCategory.value.name ??
                          "Not Selected",
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              ],
            ),
          );
    return Container(
      padding: const EdgeInsets.all(8),
      // color: AppHelperFunctions..bgColor(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("PKR", style: TextStyle(fontSize: 32.0)),
            ],
          ),
          //Row Ammount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(controller.formatCurrency(),
                  style: const TextStyle(fontSize: 48.0))),
              Icon(controller.getIconBasedOnNumber(number)),
            ],
          ),
          const Spacer(),
          // Row Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final selectedAccount = await Get.to<Account>(
                        AccountsView(onTapCallback: (account) {
                      // Do something with the selected account, e.g., navigate to another screen
                      Get.back(result: account);
                    }));
                    if (selectedAccount != null) {
                      TransactionController.instance
                          .setSelectedAccount(selectedAccount);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: AppHelperFunctions.bgColor(),

                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // Makes the button square
                    ), // Adjust the padding as needed
                  ),
                  child: Column(
                    children: [
                      Text("Account",
                          style: Theme.of(context).textTheme.bodySmall),
                      Obx(() => Text(
                          controller.getSelectedAccount.value.accountName ??
                              "Not Selected",
                          style: Theme.of(context).textTheme.labelSmall)),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 12, color: Colors.black),
              Expanded(
                child: button,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            width: double.infinity,
            child: OutlinedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      AppHelperFunctions.bgColor()),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.zero, // Makes the button square
                    ),
                  )),
              onPressed: () {
                Get.to(TransactionFormView(
                    controller: controller, number: number));
              },
              child: Text(
                "Add Details",
                style: TextStyle(color: AppHelperFunctions.textColor()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
