import 'package:manabietodo/models/task_model.dart';

class AppState {
  final List<TaskModel> tasks;

  const AppState({this.tasks});

  AppState.initState() : tasks = List.unmodifiable(<TaskModel>[]);

  AppState.fromJson(Map jsonMap) : tasks = (jsonMap['tasks'] as List).map((task) => TaskModel.fromJson(task)).toList();

  Map toJSon() => {'tasks': tasks};
}
