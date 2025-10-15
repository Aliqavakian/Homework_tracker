import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'task.dart';

enum Filter { all, active, completed }

class HomeworkRepository {
  Database? _database;

  Future<Database> get db async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'homework.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE homework (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            subject TEXT NOT NULL,
            title TEXT NOT NULL,
            due_date_millis INTEGER NOT NULL,
            completed INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Task>> fetchAll({Filter filter = Filter.all}) async {
    final database = await db;
    
    String whereClause = '';
    switch (filter) {
      case Filter.active:
        whereClause = 'WHERE completed = 0';
        break;
      case Filter.completed:
        whereClause = 'WHERE completed = 1';
        break;
      case Filter.all:
        whereClause = '';
        break;
    }
    
    final List<Map<String, dynamic>> maps = await database.query(
      'homework',
      where: filter != Filter.all ? 'completed = ?' : null,
      whereArgs: filter != Filter.all 
          ? [filter == Filter.completed ? 1 : 0] 
          : null,
      orderBy: 'due_date_millis ASC',
    );

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int> insert(Task task) async {
    final database = await db;
    final taskMap = task.toMap();
    taskMap.remove('id'); // Remove id for insert
    return await database.insert('homework', taskMap);
  }

  Future<void> updateCompleted(int id, bool completed) async {
    final database = await db;
    await database.update(
      'homework',
      {'completed': completed ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    final database = _database;
    if (database != null) {
      await database.close();
    }
  }
}