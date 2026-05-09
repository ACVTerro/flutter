import 'package:tipidbuddy/backend/database/db.dart';
import 'package:tipidbuddy/backend/models/categories.dart';

class CategoryServices {
  
  static Future<int> insert(CategoriesModel cm) async {
    final db = await DBConfig.db;
    return db.insert("categories", cm.toMap());
  }

  static Future<List<CategoriesModel>> getAll() async {
    final db = await DBConfig.db;
    final res = await db.query("categories");
    return res.map((e) => CategoriesModel.fromMap(e)).toList();
  }

  static Future<int> update(CategoriesModel c) async {
    final db = await DBConfig.db;
    return db.update(
      'categories',
      c.toMap(),
      where: 'id=?',
      whereArgs: [c.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBConfig.db;
    return db.delete('categories', where: 'id=?', whereArgs: [id]);
  }
}