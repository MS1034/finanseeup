import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import '../../exceptions/app_exceptions.dart';
import '../../models/transaction.dart';

class TransactionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTransaction( TransactionModel transaction, File? imageFile) async {
    try {
      final user=AuthenticationRepository.instance.authUser;
      if (user?.uid != null) {

        String? imageURL;

        if (imageFile != null) {
          imageURL = await uploadImage(imageFile);
        }
        transaction.receiptImage = imageURL;

        final data =transaction.toJson();
        print(data);
        await _db.collection('transactions').doc(user?.uid).collection(
            'user_transactions').add(data);
        print("yes");

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

  Future<String?> uploadImage(File imageFile) async {
    try {
      final user=AuthenticationRepository.instance.authUser;
      if (user?.uid != null) {
        String imagePath = 'images/$user.uid/${DateTime
            .now()
            .millisecondsSinceEpoch}.jpg';
        UploadTask task = FirebaseStorage.instance.ref()
            .child(imagePath)
            .putFile(imageFile);
        await task.whenComplete(() => null);

        // Get download URL
        String downloadURL = await FirebaseStorage.instance.ref(imagePath)
            .getDownloadURL();
        return downloadURL;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
    return null;
  }


  Future<List<TransactionModel>> getTransactions() async {
    try {
      String? userId = AuthenticationRepository.instance.authUser?.uid;
      if (userId != null) {
        final querySnapshot = await _db.collection('transactions').doc(userId).collection('user_transactions').get();
        return querySnapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.data()))
            .toList();
      } else {
        // Handle case where user ID is null (not authenticated)
        return [];
      }
    } catch (e) {
      // Handle error
      print('Error getting transactions: $e');
      rethrow;
    }
  }


  Future<void> updateTransaction(String userId, String transactionId, TransactionModel updatedTransaction) async {
    try {
      await _db.collection('transactions').doc(userId).collection('user_transactions').doc(transactionId).update(updatedTransaction.toJson());
    } catch (e) {
      // Handle error
      print('Error updating transaction: $e');
      rethrow;
    }
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    try {
      await _db.collection('transactions').doc(userId).collection('user_transactions').doc(transactionId).delete();
    } catch (e) {
      // Handle error
      print('Error deleting transaction: $e');
      rethrow;
    }
  }
}
