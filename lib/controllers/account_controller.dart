import 'package:finanseeup/data/repositories/account_repository.dart';
import 'package:finanseeup/utils/consts/image_strings.dart';
import 'package:finanseeup/utils/popups/full_screen_loader.dart'
    show AppFullScreenLoader;
import 'package:finanseeup/widgets/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/authentication_repository.dart';
import '../models/account.dart';
import '../utils/helpers/utils.dart';
import '../utils/network manager/network_manager.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  final _account = Get.put(AccountRepository());

  Rx<Color> pickerColor = Colors.blue.obs;

  // Existing methods...
  final _accountRepository = Get.put(AccountRepository());

  // Add the following method to update the color controller
  RxList<Account> accounts = <Account>[].obs;

  RxList<Account> get allAccounts => accounts;

  @override
  void onInit() {
    super.onInit();
    // Initialize accounts list when the controller is created
    getAccountsAndUpdateState();
  }

  //
  // Future<void> getAllLocalAccounts() async {
  //   await _accountRepository.getAllAccountsLocally().then((result) {
  //     accounts.assignAll(result);
  //   });
  // }
  Future<void> getAllLocalAccounts() async {
    accounts.value = await _accountRepository.getAllAccountsFromFirebase();
  }

  Rx<Color> get PickerColor => pickerColor;

  TextEditingController get accountNameController =>
      _accountNameFieldController;

  TextEditingController get accountTypeController => _accountTypeController;

  TextEditingController get currencyController => _currencyController;

  TextEditingController get colorController => _colorController;

  TextEditingController get initialAmountController => _initialAmountController;

  // late SignUpModel _model;
  final TextEditingController _accountNameFieldController =
      TextEditingController();
  final TextEditingController _accountTypeController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _initialAmountController =
      TextEditingController();

  GlobalKey<FormState> addNewAccountKey = GlobalKey<FormState>();

  // Get.put(NetworkManager());
  final NetworkManager _networkManager = Get.put(NetworkManager());

  Future<void> deleteAccount(Account account) async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "We are deleting your account",
        AppImages.singleCoin,
      );

      final isConnected = await _networkManager.isConnected();

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        // await _accountRepository.updateAccountLocally(
        //     account, EnumOperation.deletedLocally);
        //
        // await getAllLocalAccounts(); // Update the local accounts list
        //
        // Get.back();

        return;
      }

      await _accountRepository.deleteAccount(account);
      print(account);
      // await _accountRepository.deleteAccountLocally(account);

      // await _accountRepository.synchronizeCloudWithLocal;
      await getAllLocalAccounts();

      print("Account deleted successfully!");

      AppFullScreenLoader.stoploading();
      Get.back();
    } catch (e, stacktrace) {
      AppFullScreenLoader.stoploading();
      print(stacktrace);
      print(e);
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  Future<void> updateAmount(
      String accountId, double amountToAddOrRemove) async {
    try {
      final accountIndex =
          accounts.indexWhere((account) => account.id == accountId);

      if (accountIndex != -1) {
        final Account currentAccount = accounts[accountIndex];
        final double updatedAmount =
            currentAccount.amount! + amountToAddOrRemove;

        final updatedAccount = currentAccount.copyWith(amount: updatedAmount);

        // Update the account in the local list
        accounts[accountIndex] = updatedAccount;

        // Update the account in Firebase
        await _accountRepository.updateAccount(updatedAccount);

        // Notify listeners that the accounts list has been updated
        updateAccounts(accounts);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateAccount(Account account) async {
    try {
      // if (Id == null) {
      //   throw Error();
      // }
      AppFullScreenLoader.openLoadingDialog(
        "We are updating your information",
        AppImages.singleCoin,
      );

      if (!addNewAccountKey.currentState!.validate()) {
        AppFullScreenLoader.stoploading();
        return;
      }

      String colorCode = _colorController.text;
      Color? color = colorCode.isNotEmpty
          ? Color(int.parse(colorCode.substring(1), radix: 16))
          : null;

      final isConnected = await _networkManager.isConnected();
      double? initialAmount = double.tryParse(
          AppUtils.checkEmpty(initialAmountController.text) ?? '');
      final account1 = Account(
        id: account.id,
        accountName: AppUtils.checkEmpty(accountNameController.text),
        type: AppUtils.checkEmpty(accountTypeController.text),
        currency: AppUtils.checkEmpty(currencyController.text),
        amount: initialAmount,
        color: color,
      );

      if (!isConnected) {
        AppFullScreenLoader.stoploading();

        // await _accountRepository.updateAccountLocally(
        //     account, EnumOperation.modifiedLocally);
        // await getAllLocalAccounts(); // Update the local accounts list

        return;
      }
      print(initialAmount);
      print("==================================================Init");

      await _accountRepository.updateAccount(account1);
      // await _accountRepository.updateAccountLocally(
      //     account, EnumOperation.modifiedLocally);

      // await _accountRepository.synchronizeCloudWithLocal;
      await getAllLocalAccounts();

      print(account);
      print("Account updated successfully!");

      AppFullScreenLoader.stoploading();
      Get.back();

      AppLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been updated!',
      );
    } catch (e, stacktrace) {
      AppFullScreenLoader.stoploading();
      print(stacktrace);
      print(e);
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  Future<void> addAccount() async {
    try {
      AppFullScreenLoader.openLoadingDialog(
        "We are processing your information",
        AppImages.singleCoin,
      );

      if (!addNewAccountKey.currentState!.validate()) {
        AppFullScreenLoader.stoploading();
        return;
      }

      String colorCode = _colorController.text;
      Color? color = colorCode.isNotEmpty
          ? Color(int.parse(colorCode.substring(1), radix: 16))
          : null;

      final isConnected = await _networkManager.isConnected();
      double? initialAmount = double.tryParse(
          AppUtils.checkEmpty(initialAmountController.text) ?? '');
      final account = Account(
        accountName: AppUtils.checkEmpty(accountNameController.text),
        type: AppUtils.checkEmpty(accountTypeController.text),
        currency: AppUtils.checkEmpty(currencyController.text),
        amount: initialAmount,
        color: color,
      );

      if (!isConnected) {
        // AppFullScreenLoader.stoploading();
        // await _accountRepository.addAccountLocally(
        //     account, EnumOperation.addedLocally);
        // await getAllLocalAccounts(); // Update the local accounts list
        // Get.back();

        return;
      }

      final user = AuthenticationRepository.instance.authUser;

      if (user?.uid != null) {
        final data = account.toJson();

        final id = await _accountRepository.addAccount(account);
        account.id = id;
        // await _accountRepository.addAccountLocally(
        //     account, EnumOperation.FromFirebase);
        // await _accountRepository.syncLocalAccountsToFirebase();
        // await _accountRepository.synchronizeCloudWithLocal();

        await getAllLocalAccounts(); // Update the local accounts list

        print(account);
        print("Account added successfully!");
      }

      AppFullScreenLoader.stoploading();
      Get.back();
    } catch (e, stacktrace) {
      AppFullScreenLoader.stoploading();
      print(stacktrace);
      print(e);
      AppLoaders.errorSnackBar(title: "Oh Sorry!", message: e.toString());
    }
  }

  Future<void> getAccountsAndUpdateState() async {
    accounts.value = await _accountRepository.getAllAccountsFromFirebase();
  }

  void updateAccounts(List<Account> updatedAccounts) {
    accounts.value = updatedAccounts;
  }
}
