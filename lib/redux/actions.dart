import 'package:manabietodo/models/task_model.dart';

class AddTaskAction {
  final TaskModel task;

  AddTaskAction(this.task);
}

class TapTaskAction {
  final int taskId;

  TapTaskAction(this.taskId);
}

class GetTaskAction {}

class LoadedTasksAction {
  final List<TaskModel> tasks;

  LoadedTasksAction(this.tasks);
}
