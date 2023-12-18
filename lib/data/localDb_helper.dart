import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static final DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _databaseHelper;
  }
  static const tableAccounts = '''
        CREATE TABLE accounts (
          localId INTEGER PRIMARY KEY,
          id TEXT,
          accountName TEXT,
          type TEXT,
          currency TEXT,
          amount TEXT,
          color TEXT,
          status TEXT
        )
      ''';
  Future<Database?> openDB() async {
    String path = await getDatabasesPath();
    _database = await openDatabase(
      join(path, 'app1.db'),
      onCreate: (database, version) async {
        List<Map<String, dynamic>> tables = await database.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name='your_table_name'");

        if (tables.isEmpty) {
          // Table doesn't exist, so create it
          await database.execute(tableAccounts);
        }
      },
      version: 1,
    );
    return _database;
  }
}
