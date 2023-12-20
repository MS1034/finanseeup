import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanseeup/data/localDb_helper.dart';
import 'package:finanseeup/models/enum_operations.dart';
import 'package:finanseeup/utils/network%20manager/network_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../exceptions/app_exceptions.dart';
import '../../models/account.dart';
import 'authentication_repository.dart';

class AccountRepository extends GetxController {
  static AccountRepository get instance => Get.find();

  Database? _database;

  final String _tableName = 'accounts';
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final NetworkManager _networkManager = NetworkManager.instance;

  Future<Database?> openDB() async {
    _database = await DatabaseHelper().openDB();
    return _database;
  }

  // Future<void> synchronizeCloudWithLocal() async {
  //   try {
  //     final isConnected = await _networkManager.isConnected();
  //     if (!isConnected) {
  //       return;
  //     }
  //     final user = AuthenticationRepository.instance.authUser;
  //     if (user?.uid != null) {
  //       // Fetch all accounts from the cloud
  //       final snapshot = await _db
  //           .collection('accounts')
  //           .doc(user?.uid)
  //           .collection('user_accounts')
  //           .get();
  //
  //       final List<Account> firestoreAccounts = snapshot.docs
  //           .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //       _database = await openDB();
  //
  //       // Fetch all local accounts
  //       final localAccounts = await _database?.query(_tableName);
  //
  //       final locallyAdditions = localAccounts
  //           ?.where((localAccount) =>
  //               localAccount["status"] == EnumOperation.addedLocally)
  //           .toList();
  //
  //       for (final account in locallyAdditions!) {
  //         await addAccount(account as Account);
  //         print("====================================");
  //         print(account);
  //         print("====================================");
  //       }
  //
  //       final localDeletions = localAccounts
  //           ?.where((localAccount) =>
  //               localAccount["status"] == EnumOperation.deletedLocally)
  //           .toList();
  //       for (final account in localDeletions!) {
  //         await deleteAccount(account as Account);
  //       }
  //
  //       final localModification = localAccounts
  //           ?.where((localAccount) =>
  //               localAccount["status"] == EnumOperation.modifiedLocally)
  //           .toList();
  //
  //       // Update cloud data with locally modified or deleted accounts
  //       for (final account in localModification!) {
  //         await updateAccount(account as Account);
  //       }
  //
  //       // Identify local accounts that have been added locally
  //       // Add locally added accounts to the cloud data
  //
  //       final isConnected = await _networkManager.isConnected();
  //       if (isConnected) {
  //         await _database?.delete(_tableName);
  //       }
  //
  //       // Fetch all accounts from the cloud
  //       final List<Account> cloudAccounts = snapshot.docs
  //           .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //       for (final account in cloudAccounts) {
  //         await addAccountLocally(account, EnumOperation.FromFirebase);
  //       }
  //     }
  //
  //     // If the user is not authenticated, return an empty list
  //   } on FirebaseAuthException catch (e) {
  //     throw AppFirebaseAuthException(e.message);
  //   } on FirebaseException catch (e) {
  //     throw AppFirebaseException(e.message);
  //   } on FormatException catch (_) {
  //     throw AppFormatException();
  //   } on PlatformException catch (e) {
  //     throw AppPlatformException(e.message);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }

  Future<void> addAccountLocally(Account account, EnumOperation status) async {
    final accountData = {
      'accountName': account.accountName,
      'id': account.id,
      'type': account.type,
      'currency': account.currency,
      'amount': account.amount.toString(),
      'color': account.color?.value.toString(),
      'status': status.name,
    };
    _database = await openDB();

    await _database?.insert(_tableName, accountData);
  }

  Future<String?> addAccount(Account account) async {
    try {
      final user = AuthenticationRepository.instance.authUser;
      if (user?.uid != null) {
        final docRef = await _db
            .collection('accounts')
            .doc(user?.uid)
            .collection('user_accounts')
            .add(account.toJson());
        return docRef.id;
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  Future<void> updateAccount(Account account) async {
    try {
      final user = AuthenticationRepository.instance.authUser;
      print(account);
      print("==================================================Subhan");
      if (user?.uid != null && account.id != null) {
        print(account);
        print("==================================================Subhan");
        final accountRef = _db
            .collection('accounts')
            .doc(user?.uid)
            .collection('user_accounts')
            .doc(account.id);

        await accountRef.update(account.toJson());
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<List<Account>> getAllAccountsFromFirebase() async {
  //   try {
  //     final user = AuthenticationRepository.instance.authUser;
  //
  //     if (user?.uid != null) {
  //       final snapshot = await _db
  //           .collection('accounts')
  //           .doc(user?.uid)
  //           .collection('user_accounts')
  //           .get();
  //
  //       final acc = snapshot.docs
  //           .map((doc) => doc.data() as Map<String, dynamic>)
  //           .toList();
  //
  //       print(acc);
  //
  //       final List<Account> firebaseAccounts = snapshot.docs
  //           .map((doc) => Account.fromJson(doc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //       return firebaseAccounts;
  //     } else {
  //       // Handle the case when the user is not authenticated
  //       return [];
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw AppFirebaseAuthException(e.message);
  //   } on FirebaseException catch (e) {
  //     throw AppFirebaseException(e.message);
  //   } on FormatException catch (_) {
  //     throw AppFormatException();
  //   } on PlatformException catch (e) {
  //     throw AppPlatformException(e.message);
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
  Future<List<Account>> getAllAccountsFromFirebase() async {
    try {
      final user = AuthenticationRepository.instance.authUser;

      if (user?.uid != null) {
        final snapshot = await _db
            .collection('accounts')
            .doc(user?.uid)
            .collection('user_accounts')
            .get();

        final List<Account> firebaseAccounts = snapshot.docs.map((doc) {
          final Map<String, dynamic> data = doc.data();
          final String accountId = doc.id;
          data['id'] = accountId; // Add the document ID to the data
          return Account.fromJson(data);
        }).toList();

        print(firebaseAccounts);

        return firebaseAccounts;
      } else {
        // Handle the case when the user is not authenticated
        return [];
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteAccount(Account account) async {
    try {
      final user = AuthenticationRepository.instance.authUser;
      if (user?.uid != null && account.id != null) {
        final accountRef = _db
            .collection('accounts')
            .doc(user?.uid)
            .collection('user_accounts')
            .doc(account.id);

        // Delete the account document from Firestore
        await accountRef.delete();
      }
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseAuthException(e.message);
    } on FirebaseException catch (e) {
      throw AppFirebaseException(e.message);
    } on FormatException catch (_) {
      throw AppFormatException();
    } on PlatformException catch (e) {
      throw AppPlatformException(e.message);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Account>> getAllAccountsLocally() async {
    _database = await openDB();

    if (_database == null) {
      throw Error();
    } else {
      final List<Map<String, dynamic>> results = await _database!.query(
        _tableName,
        where: 'status != ?',
        whereArgs: [EnumOperation.deletedLocally.name],
      );

      final List<Account> accounts =
          results.map((result) => Account.fromJson(result)).toList();

      return accounts;
    }
  }

  Account mapToAccount(Map<String, dynamic> data) {
    return Account(
      id: data['id'],
      accountName: data['accountName'],
      type: data['type'],
      currency: data['currency'],
      amount: double.parse(data['amount']),
      color: data['color'] != null ? Color(int.parse(data['color'])) : null,
    );
  }

  Future<List<Map<String, dynamic>>> getAllAccountsRaw() async {
    _database = await openDB();

    final List<Map<String, dynamic>> results =
        await _database!.query(_tableName);

    return results;
  }

  Future<void> updateAccountLocally(
      Account account, EnumOperation status) async {
    final accountData = {
      'accountName': account.accountName,
      'id': account.id,
      'type': account.type,
      'currency': account.currency,
      'amount': account.amount.toString(),
      'color': account.color?.value.toString(),
      'status': status.name,
    };
    _database = await openDB();

    await _database?.update(
      _tableName,
      accountData,
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<void> deleteAccountLocally(Account account) async {
    _database = await openDB();

    if (account.id != null) {
      // If the account has an ID, delete by ID
      await _database?.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [account.id],
      );
    } else {
      // If the account does not have an ID, find the object by matching other fields
      print(account);
      print("===================================");
      await _database?.delete(
        _tableName,
        where: 'accountName = ?',
        whereArgs: [account.accountName],
      );
    }
  }
}
