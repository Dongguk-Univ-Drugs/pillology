import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

// param
final String tableSearch = "search";
final String columnId = "_id";
final String columnName = "columnName";
final String columnDate = "columnDate";

class TextSearchData {
  int id;
  String name;
  String date;

  TextSearchData({this.id, this.date, this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{columnName: name, columnDate: date};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  factory TextSearchData.fromMap(Map<String, dynamic> map) {
    return TextSearchData(name: map[columnName], date: map[columnDate]);
  }

  @override
  String toString() {
    return 'Data >> id : $id, name : $name, date : $date';
  }
}

class TextSearchDataProvider {
  TextSearchDataProvider._();
  static final TextSearchDataProvider _db = TextSearchDataProvider._();
  factory TextSearchDataProvider() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'textSearch.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $tableSearch(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            name TEXT,
            date TEXT
          )
        ''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }

  //Create
  createData(TextSearchData data) async {
    final db = await database;

    // check update
    var _list = await getAllTexts();
    if(_list.asMap() != null) {
      int keyIdx = -1;
      _list.asMap().forEach((key, value) {
        if(value.name == data.name) keyIdx = key;
      });
      if(keyIdx != -1)
        deleteText(keyIdx);        
    }

    var res = await db.rawInsert(
        'INSERT INTO $tableSearch(name, date) VALUES(?, ?)',
        [data.name, data.date]);
    return res;
  }

  //Read
  getText(int id) async {
    final db = await database;
    var res =
        await db.rawQuery('SELECT * FROM $tableSearch WHERE id = ?', [id]);
    return res.isNotEmpty
        ? TextSearchData(
            id: res.first['id'],
            name: res.first['name'],
            date: res.first['date'])
        : Null;
  }

  //Read All
  Future<List<TextSearchData>> getAllTexts() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $tableSearch');
    List<TextSearchData> list = res.isNotEmpty
        ? res
            .map((c) =>
                TextSearchData(id: c['id'], name: c['name'], date: c['date']))
            .toList()
        : [];

    return list;
  }

  //Delete
  deleteText(int id) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $tableSearch WHERE id = ?', [id]);
    return res;
  }

  //Delete All
  deleteAllTexts() async {
    final db = await database;
    db.rawDelete('DELETE FROM $tableSearch');
  }
}
