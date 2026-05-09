import 'package:tipidbuddy/backend/database/db.dart';
import 'package:tipidbuddy/backend/models/transactions.dart';

class TransactionServices {

  static Future<int> insert(TransactionsModel tm) async {
    final db = await DBConfig.db;
    return db.insert("transactions", tm.toMap());
  }

  static Future<List<Map<String, dynamic>>> getAllbyCategories() async {
    final db = await DBConfig.db;

    return db.rawQuery("""
    select
    t.*,
    c.type,
    c.label as category_name
    from transactions t
    join categories c on t.category_id = c.id
    order by t.transact_date desc
    """);
  }

  static Future<int> update(TransactionsModel t) async {
    final db = await DBConfig.db;
    return db.update(
      'transactions',
      t.toMap(),
      where: 'id=?',
      whereArgs: [t.id],
    );
  }

  static Future<int> delete(int id) async {
    final db = await DBConfig.db;
    return db.delete(
      'transactions',
      where: 'id=?',
      whereArgs: [id],
    );
  }

  static Future<Map<String, double>> monthlySummary(String month) async {
    final db = await DBConfig.db;

    final result = await db.rawQuery("""
    select
    sum(case when c.type = 'income' then t.amount else 0 end) as income,
    sum(case when c.type = 'expense' then t.amount else 0 end) as expense
    from transactions t
    join categories c on t.category_id = c.id
    where substr(t.transact_date, 1, 7) = ?
    """, [month]);

    final income = (result.first["income"] ?? 0) as num;
    final expense = (result.first["expense"] ?? 0) as num;

    return {
        "income": income.toDouble(),
        "expense": expense.toDouble(),
        "balance": (income - expense).toDouble()
    };
  }
}