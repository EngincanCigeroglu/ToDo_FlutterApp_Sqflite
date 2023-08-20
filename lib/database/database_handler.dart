
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

import '../models/task.dart';



class DatabaseHandler{
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }

    _database = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'Todoapp.db');
    var database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  _createDatabase(Database db, int version) async{
    await db.execute(
      "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, isDone INTEGER NOT NULL, date TEXT NOT NULL, priority INTEGER NOT NULL )",
    );
  }

  Future<List<Task>> getTasks() async {
    await database;
    final List<Map<String, Object?>> QueryResult = await _database!.rawQuery('SELECT * FROM tasks');

    return QueryResult.map((e) => Task.fromMap(e)).toList();
  }

  Future<Task> insert(Task taskModel) async {
    var databaseClient = await database;
    await databaseClient?.insert('tasks', taskModel.toMap());
    return taskModel;
  }

  Future<int> delete(int id) async {
    var databaseClient = await database;
    return await databaseClient!.delete(
        'tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Task taskModel) async {
    var databaseClient = await database;
    return await databaseClient!.update('tasks', taskModel.toMap(), where: 'id = ?', whereArgs: [taskModel.id]);
  }

}