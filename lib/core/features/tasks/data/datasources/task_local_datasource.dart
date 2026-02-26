import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_management_app/core/features/tasks/data/models/task_model.dart';

class TaskLocalDataSource {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'tasks.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE tasks(
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        dueDate TEXT,
        isCompleted INTEGER
        )
        ''');
      },
    );
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final result = await db.query('tasks');
    return result.map((e) => TaskModel.fromMap(e)).toList();
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db.update('tasks', task.toMap(), where: 'id=?', whereArgs: [task.id]);
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete('tasks', where: 'id=?', whereArgs: [id]);
  }
}
