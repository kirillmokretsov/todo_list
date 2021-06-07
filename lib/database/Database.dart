import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class DB {
  final dbName = "data.db";
  final tableName = "tasks";

  static final DB _singleton = DB._internal();

  late Future<Database> database;

  factory DB() {
    return _singleton;
  }

  DB._internal();

  initDB() async {
    database = openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tableName(id TEXT PRIMARY KEY, title TEXT NOT NULL, timeAdded TEXT NOT NULL, timeEdited TEXT NOT NULL, counter INTEGER NOT NULL)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert(tableName, task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      tableName,
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<Task> getTaskById(String id) async {
    final db = await database;
    final Map<String, dynamic> map =
        (await db.query(tableName, where: 'id = ?', whereArgs: [id]))[0];
    return Task.fromMap(map);
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(
      maps.length,
      (index) {
        return Task.fromMap(maps[index]);
      },
    );
  }

  Future<void> deleteTask(Task task) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
