import 'package:flutter/material.dart';
import 'package:manabietodo/models/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;
  final Function onTaskTap;

  TaskItem(this.task, {this.onTaskTap});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checked = widget.task.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    TaskModel task = widget.task;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: CheckboxListTile(
          title: Text(task.content),
          value: _checked,
          onChanged: (value) {
            setState(() {
              _checked = value;
              widget.onTaskTap();
            });
          },
          activeColor: Colors.green,
        ));
  }
}
