import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:manabietodo/ui/widgets/task_item.dart';

class TaskPage extends StatefulWidget {
  final List<TaskModel> tasks;
  final Function onTaskTap;
  final TaskPageFrom fromPage;

  TaskPage(this.tasks, this.onTaskTap, this.fromPage);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return widget.tasks.length > 0
        ? Container(
            padding: const EdgeInsets.only(top: 5),
            child: ListView.builder(
              itemCount: widget.tasks.length,
              itemBuilder: (context, index) {
                TaskModel task = widget.tasks[index];
                return TaskItem(task,
                    onTaskTap: () => widget.onTaskTap(task.id));
              },
            ),
          )
        : Container(
            child: Center(
                child: widget.fromPage == TaskPageFrom.all
                    ? Text("You have no task")
                    : Text(
                        "You have no ${describeEnum(widget.fromPage)} task")),
          );
  }
}

enum TaskPageFrom { all, pending, complete }
