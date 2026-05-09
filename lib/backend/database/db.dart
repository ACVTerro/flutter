import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBConfig {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  static Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final directory = Directory(databasePath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    final path = join(databasePath, 'budgeting.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table if not exists categories(
            id integer primary key autoincrement,
            label text,
            type text
          )
        ''');

        await db.execute('''
          create table if not exists transactions(
            id integer primary key autoincrement,
            amount real,
            category_id int,
            note text,
            transact_date text,
            foreign key (category_id) references categories(id)
              on delete set null
              on update cascade
          )
        ''');

        await db.execute('''
          create table if not exists budget(
            id integer primary key autoincrement,
            category_id int,
            budget_amount real,
            status text,
            month text,
            note text,
            foreign key (category_id) references categories(id)
              on delete cascade
              on update cascade
          )
        ''');
      },
    );
  }
}