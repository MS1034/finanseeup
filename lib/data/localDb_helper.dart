import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:finanseeup/utils/consts/database_constants.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static const String databaseName = 'FinanseeUp.db';
  static const int databaseVersion = 1;
  static Database? _database;

  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    sqfliteFfiInit();
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      databaseFactory = databaseFactoryFfi;
    }

    return _databaseHelper;
  }

  Future<Database?> openDB() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(join(path, databaseName),
        version: databaseVersion, onCreate: _onCreate);

    return _database;
  }

  Future<void> _onCreate(Database database, int version) async {
    for (String tableName in tables.keys) {
      List<Map<String, dynamic>> tableExistenceCheck = await database.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'");

      if (tableExistenceCheck.isEmpty) {
        // Table doesn't exist, so create it
        await database.execute(tables[tableName]!);
        print("Creating $tableName");
      }
    }
  }

  Future<void> printTablesWithRowCount() async {
    if (_database == null) {
      return;
    }

    for (String tableName in tables.keys) {
      int rowCount = Sqflite.firstIntValue(
        await _database!.rawQuery('SELECT COUNT(*) FROM $tableName'),
      )!;
      print('Table: $tableName, Row Count: $rowCount');
    }
  }
}
