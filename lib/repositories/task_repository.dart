import 'package:sqflite/sqflite.dart';
import '../db/app_database.dart';
import '../models/task.dart';

class TaskRepository {
  static const String table = 'tasks';

  Future<int> insertTask(Task task) async {
    final db = await AppDatabase.instance.database;
    return db.insert(
      table,
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Task>> getAllTasks() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      table,
      orderBy: 'created_at DESC',
    );
    return maps.map((e) => Task.fromMap(e)).toList();
  }

  Future<int> updateTask(Task task) async {
    final db = await AppDatabase.instance.database;
    return db.update(
      table,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(String id) async {
    final db = await AppDatabase.instance.database;
    return db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteAll() async {
    final db = await AppDatabase.instance.database;
    return db.delete(table);
  }
}
