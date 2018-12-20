import 'package:to_do_app/models/db_model.dart';
import 'package:sqflite/sqflite.dart';

class ToDo {
  String id;
  String title;
  String content;
  String isCompleted;
  DateTime dateTime;
  DBHelper dbHelper = DBHelper();

  ToDo({this.title, this.content, this.dateTime, this.isCompleted});

  ToDo.fromMap(Map<String, dynamic> map) {
    map['id'] != null ? this.id = map['id'].toString() : null;
    this.title = map['title'];
    this.content = map['content'];
    this.dateTime =
        DateTime.fromMillisecondsSinceEpoch(num.parse(map['dateTime']));
    this.isCompleted = map['isCompleted'].toString();
  }

  Map<String, dynamic> toMap(ToDo todo) {
    return {
      'id': todo.id,
      'title': todo.title,
      'content': todo.content,
      'dateTime': todo.dateTime.millisecondsSinceEpoch.toString(),
      'isCompleted': todo.isCompleted,
    };
  }

  Future<void> createToDo(ToDo todo) async {
    Database db = await dbHelper.db;
    await db.insert(dbHelper.dbName, toMap(todo));
  }

  static Future<List<ToDo>> readAllToDo() async {
    DBHelper dbHelper = DBHelper();
    Database db = await dbHelper.db;
    List<ToDo> todo = List<ToDo>();
    List<Map<String, dynamic>> data = await db.rawQuery("SELECT * FROM todo");
    print(data);
    for (Map<String, dynamic> _ in data) {
      todo.add(ToDo.fromMap(_));
    }
    return todo;
  }

  static Future accomplishToDo(ToDo todo) async {
    DBHelper dbHelper = DBHelper();
    Database db = await dbHelper.db;
    String setBit = "0";
    if (todo.isCompleted == '0')
      setBit = "1";
    else if (todo.isCompleted == '1') setBit = '0';
    await db.update('todo', {'isCompleted': setBit},
        where: 'id=?',
        whereArgs: [
          todo.id,
        ]);
  }
}
