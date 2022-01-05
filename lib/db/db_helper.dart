import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taskkey/models/task.dart';

/// tuki pa inicializiramo Bazo
/// Data Base File
class DBHelper {
  static Database _db; //  DB
  static final int _version = 1; // rabiš dat še verzijo
  static final String _tableName = 'tasks'; // pa ime table name oz database name

  static Future<void> initDb() async { // init method, inicializacija Data basea
    if (_db != null) {
      debugPrint("not null db");
      return; //če že obstaja sam returnamo
    }
    try {
      //če ne pa inicializiramo db
      ///ustvarmo DB
      String _path = await getDatabasesPath() + 'tasks.db'; // DataBase is Created
      debugPrint("in database path");
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          debugPrint("creating a new one");
          /// ustvarmo Tabelo v DBju
          return db.execute( // Table is Created in Data Base
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "color INTEGER, "
                "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  /// insert part
  static Future<int> insert(Task task) async {
    print("insert function called");
    return await _db.insert(_tableName, task.toJson());
  }
  /// delete part če je prazna
  static Future<int> delete(Task task) async =>
      await _db.delete(_tableName, where: 'id = ?',
          whereArgs: [task.id]);

  /// poizvedba
  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return _db.query(_tableName);
  }

  /// update tablea ko
  static Future<int> update(int id) async {
    print("update function called");
    return await _db.rawUpdate('''
    UPDATE tasks   
    SET isCompleted = ?
    WHERE id = ?
    ''', [1, id]);
  }
}
