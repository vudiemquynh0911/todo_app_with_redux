import 'package:flutter/material.dart';
import 'package:manabietodo/models/task_model.dart';

showAddNewDialog(BuildContext context) {
  var _contentController = TextEditingController();
  String inputContent = " ";

  _validateAddNew() {
    if(inputContent.trim().isEmpty) return false;
      Navigator.pop(
          context,
          TaskModel(
              content: inputContent));
      return true;

  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
            title: Text("Add your new task"),
            backgroundColor: Theme.of(context).cardColor,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            actions: <Widget>[
              FlatButton(
                child: Text("OK", style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  bool isValidate = _validateAddNew();
                  if(!isValidate) {
                    setState(() {
                      inputContent = inputContent.trim();
                    });
                  }
                }
              )
            ],
            content: Container(
                width: MediaQuery.of(context).size.width / 4 * 3,
                child:
                    Column(mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                  TextField(
                    style: Theme.of(context).textTheme.bodyText1,
                    controller: _contentController,
                    onChanged: (value) {
                      setState(() {
                        inputContent = value;
                      });
                    },
                    maxLength: 70,
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).cardColor,
                      filled: true,
                      hintText: 'Content',
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 0),
                      border: new UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.red)),
                      errorText: (inputContent.isEmpty) ? "Content is required" : null
                    ),
                  ),
                ])));
      });
    },
  );
}
