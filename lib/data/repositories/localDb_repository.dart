import 'package:finanseeup/data/localDb_helper.dart';
import 'package:finanseeup/models/crud_model.dart';
import 'package:finanseeup/models/transaction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class BaseRepository<T extends CrudModel> {
  late final String tableName;

  Future<void> insert(T item);
  // Future<List<T>> getAll();
  Future<void> update(T item);
  Future<void> delete(String id);
  // T fromJson(Map<String, dynamic> json); // Added this method
}

// ignore: camel_case_types
class localDb_Repository<T extends CrudModel> implements BaseRepository<T> {
  @override
  late final String tableName;
  localDb_Repository(this.tableName);

  @override
  Future<void> insert(T item) async {
    // print("Nani");
    final Database db = await openDatabaseHelper();
    await db.insert(tableName, item.toJsonLocally(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // @override
  // Future<List<T>> getAll() async {
  //   final Database db = await openDatabaseHelper();
  //   final List<Map<String, dynamic>> maps = await db.query(tableName);
  //   return List.generate(maps.length, (i) {
  //     return T.fromJson(maps[i]) as T;
  //   });
  // }

  @override
  Future<void> update(T item) async {
    final Database db = await openDatabaseHelper();
    await db.update(
      tableName,
      item.toJsonLocally(),
      where: 'id = ?',
      whereArgs: [item.toJsonLocally()['id']],
    );
  }

  @override
  Future<void> delete(String id) async {
    final Database db = await openDatabaseHelper();
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Database> openDatabaseHelper() async {
    final String path = await getDatabasesPath();
    return openDatabase(
      join(path, DatabaseHelper.databaseName),
      version: 1,
    );
  }
}
