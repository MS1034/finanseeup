import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanseeup/data/localDb_helper.dart';
import 'package:finanseeup/data/repositories/authentication_repository.dart';
import 'package:finanseeup/models/crud_model.dart';
import 'package:finanseeup/models/goal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

import '../../exceptions/app_exceptions.dart';

class GoalRepository {
  Future<List<Goal>> getAll() async {
    final Database? db = DatabaseHelper.getDb();
    if (db == null) {
      DatabaseHelper.showDbError();
      return [];
    }

    final List<Map<String, dynamic>> maps = await db.query("goals");
    List<Goal> transactions = [];
    transactions = maps.map((data) {
      return Goal.fromJsonLocally(data);
    }).toList();

    return transactions;
  }
}
