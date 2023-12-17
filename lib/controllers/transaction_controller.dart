import 'dart:io';

import 'package:finanseeup/data/repositories/transaction.dart';
import 'package:finanseeup/models/model_category.dart';
import 'package:finanseeup/models/transaction.dart';
import 'package:finanseeup/widgets/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../models/account.dart';
import '../models/enum_payment_type.dart';
import '../models/enum_transaction_type.dart';
import '../models/label.dart';
import '../utils/consts/image_strings.dart';
import '../utils/helpers/utils.dart';
import '../utils/network manager/network_manager.dart';
import '../utils/popups/full_screen_loader.dart';
import '../views/home.dart';

class TransactionController extends GetxController {
  // Singleton instance
  static TransactionController get instance => Get.find();

  // Icon based on the number
  IconData getIconBasedOnNumber(int num) {
    if (num == 1) {
      return Icons.add;
    } else if (num == 2) {
      return Icons.remove;
    } else {
      return Icons.swap_horiz_outlined; // Or any other default icon
    }
  }

  // Observables
  final RxDouble amount = 0.0.obs;

  final RxList<LabelModel> _labels = [
    LabelModel(name: "Label 1", id: "1"),
    LabelModel(name: "Label 2", id: "2"),
    LabelModel(name: "Label 3", id: "3"),
    LabelModel(name: "Label 4", id: "4"),
  ].obs;

  List<MultiSelectItem<LabelModel>> get getLabels {
    return _labels.map((label) {
      return MultiSelectItem<LabelModel>(label, label.name);
    }).toList();
  }

  final TextEditingController labelController = TextEditingController();
  final TextEditingController payeeController = TextEditingController();
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  late DateTime _dateTime = DateTime.now();
  final TextEditingController timeController =
      TextEditingController(text: DateFormat('HH:mm').format(DateTime.now()));
  final TextEditingController paymentTypeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final Rx<DateTime> selectedDate = DateTime.now().obs;
  final Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;

  final RxList<String> selectedLabels = <String>[].obs;

  final RxList<Color> labelColors = <Color>[].obs;

  late final Rx<Account> account = Account(
    id: "fbs16",
    accountName: null,
    type: null,
    currency: null,
  ).obs;

  late final Rx<Account> account2 = Account(
    id: "fbs16",
    accountName: null,
    type: null,
    currency: null,
  ).obs;

  void addDate(DateTime dateToAdd) {
    // Extract time from _dateTime
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(_dateTime);

    // Create a new DateTime with the given date and preserved time
    _dateTime = DateTime(
      dateToAdd.year,
      dateToAdd.month,
      dateToAdd.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }

  void addTime(TimeOfDay timeToAdd) {
    // Extract date from _dateTime
    DateTime date = DateTime(_dateTime.year, _dateTime.month, _dateTime.day);

    // Create a new DateTime with the preserved date and the given time
    _dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      timeToAdd.hour,
      timeToAdd.minute,
    );
  }

  late final Rx<CategoryModel> category = CategoryModel(name: null).obs;

  // Getters
  TextEditingController get getLabelController => labelController;

  TextEditingController get getPayeeController => payeeController;

  TextEditingController get getDateController => dateController;

  TextEditingController get getTimeController => timeController;

  TextEditingController get getPaymentTypeController => paymentTypeController;

  TextEditingController get getDescriptionController => descriptionController;

  RxList<String> get getSelectedLabels => selectedLabels;

  Rx<Account> get getSelectedAccount => account;

  Rx<Account> get getSelectedAccount2 => account2;

  void setSelectedAccount(Account newAccount) {
    print("Subhan in Account1");

    // Check if the new account is different from the current one
    if (account2.value != newAccount) {
      // If different, set the new account to the second account
      account.value = newAccount;
    } else {
      print("swap1");

      // If the accounts are the same, swap their values
      Account temp = account.value;
      account.value = account2.value;
      account2.value = temp;
    }
  }

  void setSelectedAccount2(Account newAccount) {
    print("Subhan in Account2");
    print(newAccount);
    print(account.value);

    // Check if the new account is different from the current one
    if (account.value != newAccount) {
      print("not swap2");

      // If different, set the new account to the second account
      account2.value = newAccount;
    } else {
      print("swap2");
      // If the accounts are the same, swap their values
      Account temp = account.value;
      account.value = account2.value;
      account2.value = temp;
    }
  }

  Rx<CategoryModel> get getSelectedCategory => category;

  // Function to add a label to the list
  void addLabel(LabelModel label) {
    labelController.clear();
    _labels.add(label);

    Get.back(); // Close the bottom sheet
  }

  String formatCurrency() {
    if (amount <= 1e8) {
      // If the amount is greater than or equal to 1 trillion, switch to human-readable format
      return amount.toString();
    } else {
      // Otherwise, use the compact currency format
      return NumberFormat.compactCurrency(
        decimalDigits: 2,
        symbol: '',
      ).format(amount.value);
    }
  }

  void updateAmount(double newAmount) {
    amount.value = newAmount;
  }

  Rx<File?> receiptImage = Rx<File?>(null);

  // Getter for receiptImage
  File? get getReceiptImage => receiptImage.value;

  // Function to add the selected image to the controller
  void addReceiptImage(File image) {
    receiptImage.value = image;
    if (kDebugMode) {
      print(receiptImage.value);
    }
  }

  TransactionType getTransactionType(int num) {
    if (num == 1) {
      return TransactionType.Income;
    } else if (num == 2) {
      return TransactionType.Expense;
    }
    return TransactionType.Transfer;
  }
  final NetworkManager _networkManager = Get.put(NetworkManager());


  final _transaction = Get.put(TransactionRepository());

  TransactionController();

  Future<void> addTransaction(int num) async {
    try {

      AppFullScreenLoader.openLoadingDialog(
          "We are processing your information", AppImages.singleCoin);
      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        return;
      }


      TransactionType transactionType = getTransactionType(num);
      // Validate required fields before adding a record
      if (amount.value == 0.0 || getSelectedAccount.value.id == null) {
        AppFullScreenLoader.stoploading();

        // Handle the case where required fields are not filled
        AppLoaders.errorSnackBar(
            title: 'Error', message: 'Please fill in all required fields.');

        return;
      }
      if (transactionType == TransactionType.Transfer &&
          getSelectedAccount2.value.accountName == null) {
        AppFullScreenLoader.stoploading();

        AppLoaders.errorSnackBar(
            title: 'Error', message: 'Please fill in all required fields.');

        return;
      } else if (category.value.name == null) {
        AppFullScreenLoader.stoploading();

        AppLoaders.errorSnackBar(
            title: 'Error', message: 'Please fill in all required fields.');
        return;
      }

      // Check and set default values for optional fields
      String? description =
          AppUtils.checkEmpty(descriptionController.text.trim());

      List<String>? labels = selectedLabels.value;
      String? payee = AppUtils.checkEmpty(payeeController.text.trim());

      DateTime? dateTime = _dateTime;

      var paymentType =
          AppUtils.checkEmpty(payeeController.text) ;

      // String? receiptImage = this.receiptImage;

      // Create a new TransactionModel instance
      TransactionModel record = TransactionModel(
        accountId: getSelectedAccount.value.id!,
        category: category.value.name!,
        amount: amount.value,
        description: description,
        labels: labels.isEmpty ? null : labels,
        payee: payee,
        // Set default value as an empty list
        dateTime: dateTime ?? DateTime.now(),
        paymentType: paymentType,
        transactionType: transactionType.name,
      );


      // Save the record using your repository method
      await _transaction.addTransaction(record, receiptImage.value);

      print("yes");

      amount.value = 0.0;
      getSelectedAccount.value = Account(
        accountName: null,
        type: null,
        currency: null,
      );
      category.value = CategoryModel(name: null);
      selectedDate.value = DateTime.now();
      selectedTime.value = TimeOfDay.now();
      selectedLabels.clear();
      payeeController.clear();
      payeeController.clear();
      dateController.clear();
      descriptionController.clear();
      receiptImage.value = null;
      Get.to(const HomeView(title: "Home"));

      AppLoaders.successSnackBar(
        title: 'Saved',
        message:
        'Record added successfully.',
      );


      // Show success message or navigate to another screen
      if (kDebugMode) {
        print('Record added successfully!');
      }
    } catch (e) {
      AppFullScreenLoader.stoploading();

      // Handle any errors that might occur during the process
      AppLoaders.errorSnackBar(
        title: 'Error',
        message:
            'Error adding record. Please try again. Details: ${e.toString()}',
      );

      //   AppLoaders.errorSnackBar(
      //       title: 'Error', message: 'Error adding record. Please try again.');
      // }
    }
  }
}
