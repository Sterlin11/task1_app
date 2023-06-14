import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/detail.dart';

class DatabaseHelper {
  static const _databaseName = "detailsDb.db";
  static const _databaseVersion = 1;

  static const tableName = "detail_table";

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnLuckyNumber = 'luckyNumber';
  static const columnSalary = 'salary';

// only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnLuckyNumber INTEGER NOT NULL,
            $columnSalary DOUBLE NOT NULL
          )
          ''');
  }

//to insert
  Future<int> insert(Detail detail) async {
    Database db = await getDatabase();
    return await db.insert(tableName, {
      'name': detail.name,
      'luckyNumber': detail.luckyNumber,
      'salary': detail.salary
    });
  }

//to view all
  Future<List<Map<String, dynamic>>> showAll() async {
    Database db = await getDatabase();
    return await db.query(tableName);
  }

//to delete
  Future<int> delete(int id) async {
    Database db = await getDatabase();
    return await db.rawDelete("DELETE from $tableName WHERE id=$id");
  }

  //to update
  Future<int> update(Detail detail, int id) async {
    Database db = await getDatabase();
    debugPrint("The update id in update() is $id");
    return await db
        .update(tableName, detail.toMap(), where: "id=?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> showAllForTable() async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> map = await db.query(tableName);
    return map.toList();
  }

  Future<List> searchDetail(String keyword) async {
    Database db = await getDatabase();
    return await db
        .query(tableName, where: 'name LIKE ?', whereArgs: ['%$keyword%']);
  }
}
