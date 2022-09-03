import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'databaseModel/LoginDetail.dart';

class DBHelper {

  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    print("get");

    _database = await _initDB('stdev_contact_db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print("_initDB");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    // final decimalType = 'DECIMAL NOT NULL';

    await db.execute('''
CREATE TABLE loginDetailTable ( 
  id INTEGER PRIMARY KEY, 
  isLoggedIn BOOLEAN NOT NULL
  )
''');

    print("created");
  }

  Future<bool> createLoginDetailTable(LoginDetail loginDetail) async {
    final db = await instance.database;
    final id = await db.insert("loginDetailTable", loginDetail.toJson());
    return true;
  }

  Future<LoginDetail> readLoginDetail(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      "loginDetailTable",
      columns: ["id", "isLoggedIn"],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return LoginDetail.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<LoginDetail>> readAllLoginDetails() async {
    final db = await instance.database;

    final result = await db.query("loginDetailTable");

    return result.map((json) => LoginDetail.fromJson(json)).toList();
  }

  Future<int> updateLoginDetailTable(LoginDetail loginDetail) async {
    final db = await instance.database;

    return db.update(
      "loginDetailTable",
      loginDetail.toJson(),
      where: 'id = ?',
      whereArgs: [loginDetail.id],
    );
  }

  Future<int> deleteLoginDetailTable(int id) async {
    final db = await instance.database;

    return await db.delete(
      "loginDetailTable",
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

