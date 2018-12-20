import 'package:flutter/material.dart';
import 'package:to_do_app/ui/create.dart';
import 'package:to_do_app/ui/home.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:to_do_app/models/user_model.dart';

void main() async {
  UserModel userModel = UserModel();
  userModel.readToDo();
  runApp(ToDoApp(
    userModel: userModel,
  ));
}

class ToDoApp extends StatelessWidget {
  final UserModel userModel;

  const ToDoApp({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: userModel,
      child: MaterialApp(
        title: "To Do App",
        home: Home(),
        theme: ThemeData(fontFamily: 'BreeSerif'),
        routes: {
          '/create': (_) => Create(),
        },
      ),
    );
  }
}
