import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBHelper {
  static DBHelper _dbHelper = DBHelper._();

  Database _db;

  Future<Database> get db async => _db ??= await initDb();

  Future<Database> initDb() async {
    Directory _dir = await getApplicationDocumentsDirectory();
    String path = join(_dir.path, dbName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  DBHelper._();

  factory DBHelper() => _dbHelper;

  String get dbName => 'todo';

  _onCreate(Database database, int version) {
    database.execute(""
        "CREATE TABLE todo("
        "id INTEGER PRIMARY KEY,"
        "title TEXT,"
        "content TEXT,"
        "dateTime TEXT,"
        "isCompleted INTEGER)");
  }
}
