import 'package:tipidbuddy/backend/database/db.dart';
import 'package:tipidbuddy/backend/models/budget.dart';

class BudgetServices {

  static Future<int> insert(BudgetModel b) async {
    final db = await DBConfig.db;
    return db.insert('budget', b.toMap());
  }

  static Future<List<BudgetModel>> getAll() async {
    final db = await DBConfig.db;
    final res = await db.query('budget');
    return res.map((e) => BudgetModel.fromMap(e)).toList();
  }

  static Future<int> update(BudgetModel b) async {
    final db = await DBConfig.db;
    return db.update(
      'budget',
      b.toMap(),
      where: 'id=?',
      whereArgs: [b.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBConfig.db;
    return db.delete('budget', where: 'id=?', whereArgs: [id]);
  }
}