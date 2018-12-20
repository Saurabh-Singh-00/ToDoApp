import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:to_do_app/models/to_do_model.dart';
import 'package:to_do_app/models/user_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  bool fabVisible = true;
  double _scrollStart = .0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_scrollStart < _scrollController.offset) {
      setState(() {
        fabVisible = false;
        _scrollStart = _scrollController.offset;
      });
    } else {
      setState(() {
        fabVisible = true;
        _scrollStart = _scrollController.offset;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Scaffold(
            appBar: AppBar(
              title: Text("ToDo"),
              elevation: .0,
              centerTitle: true,
            ),
            body: model.todoList == null || model.todoList == <ToDo>[]
                ? Center(
                    child: Text(""
                        "No tasks yet, relax"),
                  )
                : ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (context, pos) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            model.todoList[pos].title,
                            style: TextStyle(
                                decorationStyle: TextDecorationStyle.solid,
                                color: model.todoList[pos].isCompleted == "1"
                                    ? Colors.black45
                                    : Colors.black,
                                decoration: TextDecoration.combine([
                                  model.todoList[pos].isCompleted == "1"
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ])),
                          ),
                          subtitle: Text(
                              "${DateTime.fromMillisecondsSinceEpoch(model.todoList[pos].dateTime.millisecondsSinceEpoch)}"),
                          trailing: Checkbox(
                            value: model.todoList[pos].isCompleted == "0"
                                ? false
                                : true,
                            onChanged: (checkedValue) {
                              model.accomplishToDo(model.todoList[pos]);
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: model.todoList.length,
                    separatorBuilder: (context, pos) {
                      return Divider(
                        height: 2.0,
                      );
                    },
                  ),
            floatingActionButton: fabVisible
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/create');
                    },
                    child: Icon(Icons.add),
                  )
                : null,
          ),
    );
  }
}
