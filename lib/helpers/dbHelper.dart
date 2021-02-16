import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';
import 'package:todoeyid/models/tasks.dart';

class DBHelper {
  static Future<Database> databaseTasks() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      // path.join is going to find is there any DB in the 'Phone Storage' & automatically create a new DB if it didn't find any DB with the name that you've specified below
      path.join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE tasks(taskID TEXT PRIMARY KEY, name TEXT, taskDate TEXT, isDone INTEGER Default 0)');
      },
      version: 1,
    );
  }

  static Future<Database> databaseSettings() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      // path.join is going to find is there any DB in the 'Phone Storage' & automatically create a new DB if it didn't find any DB with the name that you've specified below
      path.join(dbPath, 'settings.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE settings(ProfileName TEXT PRIMARY KEY, isDarkMode INTEGER Default 0)');
      },
      version: 1,
    );
  }

  static Future<void> insertData(String table, Map<String, Object> data) async {
    // Insert Data
    final db = table == "tasks"
        ? await DBHelper.databaseTasks()
        : await DBHelper.databaseSettings();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getTasksData(String table) async {
    // Fetch Data
    final db = await DBHelper.databaseTasks();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getTasksDate(String table) async {
    // Fetch Data
    final db = await DBHelper.databaseTasks();
    return db.query(table, groupBy: 'taskDate');
  }

  static Future<List<Map<String, dynamic>>> getTasksDataWithDate(
      String table, String taskDate) async {
    // Fetch Data
    final db = await DBHelper.databaseTasks();
    return db.query(table, where: 'taskDate = ?', whereArgs: [taskDate]);
  }

  static Future<void> updateData(String table, Task task) async {
    final db = table == "tasks"
        ? await DBHelper.databaseTasks()
        : await DBHelper.databaseSettings();
    db.update(table, task.toMap(),
        where: 'taskID = ?', whereArgs: [task.taskID]);
  }

  static Future<void> deleteData(String table, String taskID) async {
    final db = table == "tasks"
        ? await DBHelper.databaseTasks()
        : await DBHelper.databaseSettings();
    db.delete(table, where: 'taskID = ?', whereArgs: [taskID]);
  }
}
