import 'package:scoped_model/scoped_model.dart';
import 'package:to_do_app/models/to_do_model.dart';

class UserModel extends Model {
  List<ToDo> todoList;

  /// User can create, remove and edit a [Task]
  Future<void> createToDo(Map<String, String> map) async {
    ToDo toDo = ToDo.fromMap(map);
    await toDo.createToDo(toDo);
    readToDo();
    notifyListeners();
  }

  void editToDo(ToDo todo) async {}

  void removeToDo(ToDo todo) async {}

  void readToDo() async {
    // read all task as soon as app loads
    todoList = await ToDo.readAllToDo();
    notifyListeners();
  }

  void accomplishToDo(ToDo todo) async {
    await ToDo.accomplishToDo(todo);
    readToDo();
    notifyListeners();
  }
}
