import 'package:currency_picker/currency_picker.dart';
import 'package:finanseeup/utils/validators/validations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/account_controller.dart';
import '../models/account.dart';
import '../models/enum_account_type.dart';
import '../widgets/color_picker.dart';

class AddAccountView extends StatelessWidget {
  final AccountController controller;

  // Constructor for AddAccountView
  AddAccountView({
    Key? key,
    required this.controller,
    this.account, // Optional account parameter
  }) : super(key: key) {
    // Use the 'account' parameter if it is provided; otherwise, create a new Account
    final Account? currentAccount = account;

    // Set default values for the controllers based on the 'account' parameter
    controller.accountNameController.text = currentAccount?.accountName ?? '';
    controller.accountTypeController.text = currentAccount?.type ?? '';
    controller.currencyController.text = currentAccount?.currency ?? '';
    controller.initialAmountController.text =
        currentAccount?.amount?.toString() ?? '';
  }
  final Account? account;

  @override
  Widget build(BuildContext context) {
    final Account? currentAccount = account;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (account == null) {
                controller.addAccount();
              } else {
                // If 'account' is provided, update the existing account
                controller.updateAccount(account!);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.addNewAccountKey,
          child: ListView(
            children: [
              AccountNameField(
                controller: controller,
                initialText: currentAccount?.accountName ?? '',
              ),
              AccountTypeField(
                controller: controller,
                initialText: currentAccount?.type ?? '',
              ),
              CurrencyPickerField(
                controller: controller,
                initialText: currentAccount?.currency ?? '',
              ),
              InitialAmountField(
                controller: controller,
                initialText: currentAccount?.amount.toString() ?? "0",
              ),
              ColorPickerField(
                controller: controller,
                initialText: '',
              ),
              const SizedBox(
                height: 15,
              ),
              if (account != null)
                ElevatedButton.icon(
                  onPressed: () {
                    controller.deleteAccount(account!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8), // Adjust the border radius as needed
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AccountTypeField extends StatelessWidget {
  final AccountController controller;
  final String initialText;

  const AccountTypeField(
      {Key? key, required this.controller, required this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.accountTypeController,
      validator: (value) => AppValidations.validateEmptyText(value),
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Account Type',
        suffixIcon: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _showPopup(controller),
        ),
      ),
    );
  }

  void _showPopup(AccountController controller) {
    showModalBottomSheet(
      context: Get.context!,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AccountType.values.map((AccountType) {
              return ListTile(
                title: Text(AccountType.name),
                onTap: () {
                  controller.accountTypeController.text = AccountType.name;
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class CurrencyPickerField extends StatelessWidget {
  final AccountController controller;
  final String initialText;

  const CurrencyPickerField(
      {Key? key, required this.controller, required this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.currencyController,
      readOnly: true,
      decoration: InputDecoration(
        labelText: 'Currency',
        suffixIcon: IconButton(
          icon: const Icon(Icons.attach_money),
          onPressed: () => _showCurrencyPicker(context, controller),
        ),
      ),
    );
  }

  void _showCurrencyPicker(BuildContext context, AccountController controller) {
    showCurrencyPicker(
      context: context,
      onSelect: (Currency currency) {
        controller.currencyController.text = currency.code;
      },
    );
  }
}

class InitialAmountField extends StatelessWidget {
  final AccountController controller;
  final String initialText;

  const InitialAmountField(
      {Key? key, required this.controller, required this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller.initialAmountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Initial Amount',
      ),
    );
  }
}

class AccountNameField extends StatelessWidget {
  final AccountController controller;
  final String initialText;

  const AccountNameField(
      {Key? key, required this.controller, required this.initialText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) => AppValidations.validateEmptyText(value),
      controller: controller.accountNameController,
      decoration: const InputDecoration(
        labelText: 'Account Name',
      ),
    );
  }
}
