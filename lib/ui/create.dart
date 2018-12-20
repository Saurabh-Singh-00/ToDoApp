import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:to_do_app/models/user_model.dart';

class Create extends StatefulWidget {
  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String title = "", content = "";
  TextEditingController titleTextController = TextEditingController();
  TextEditingController contentTextController = TextEditingController();
  Map<String, String> _save = Map<String, String>();

  Map<String, String> _handleSubmit() {
    FormState formState = _formKey.currentState;
    String dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    if (formState.validate()) {
      _save['id'] = null;
      _save['title'] = titleTextController.text;
      _save['content'] = contentTextController.text;
      _save['isCompleted'] = '0';
      _save['dateTime'] = dateTime;
      print(_save);
      formState.save();
    } else {
      titleTextController.clear();
      contentTextController.clear();
    }
    return _save;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Create ToDo"),
          elevation: .0,
          centerTitle: true,
        ),
        body: Container(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "#Create To Do",
                        style: TextStyle(
                            fontSize: 28.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 4.0),
                      child: TextFormField(
                        controller: titleTextController,
                        //validator: (val) => val != "" ? title = val : "Please fill value",
                        onSaved: (val) => val != "" ? title = val : null,
                        style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "Title",
                          border: UnderlineInputBorder(),
                          hasFloatingPlaceholder: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                      child: TextFormField(
                        controller: contentTextController,
                        //validator: (val) => val != "" ? content = val : "Please fill value",
                        onSaved: (val) => val != "" ? content = val : null,
                        style: TextStyle(
                          fontSize: 26.0,
                          color: Colors.black,
                        ),
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: "Content",
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await model.createToDo(_handleSubmit());
                          }
                          Navigator.of(context).pop();
                        },
                        color: Colors.blue,
                        icon: Icon(
                          Icons.save_alt,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
