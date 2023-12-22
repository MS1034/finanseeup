import 'package:finanseeup/data/localDb_helper.dart';
import 'package:finanseeup/data/repositories/localDb_repository.dart';
import 'package:finanseeup/models/model_category.dart';
import 'package:sqflite/sqflite.dart';

class CategoriesRepository {
  static Future<void> setUp() async {
    final Database? db = DatabaseHelper.getDb();
    if (db == null) {
      DatabaseHelper.showDbError();
      return;
    }

    await db.delete("categories");

    List<CategoryModel> categories = [
      CategoryModel(name: "name1", icon: "icon1", subcategories: [
        SubcategoryModel(name: "sub1"),
        SubcategoryModel(name: "sub2")
      ]),
      CategoryModel(name: "name2", icon: "icon2", subcategories: [
        SubcategoryModel(name: "sub3"),
        SubcategoryModel(name: "sub4")
      ]),
      CategoryModel(name: "name3", icon: "icon3", subcategories: [
        SubcategoryModel(name: "sub5"),
        SubcategoryModel(name: "sub6")
      ])
    ];

    for (final CategoryModel category in categories) {
      final Repo = localDb_Repository<CategoryModel>("categories");
      await Repo.insert(category);
    }
  }

  static Future<List<CategoryModel>> getAll() async {
    final Database? db = DatabaseHelper.getDb();
    if (db == null) {
      DatabaseHelper.showDbError();
      return [];
    }

    final List<Map<String, dynamic>> maps = await db.query("categories");
    List<CategoryModel> categories = [];
    categories = maps.map((data) {
      return CategoryModel.fromJsonLocally(data);
    }).toList();

    return categories;
  }
}
