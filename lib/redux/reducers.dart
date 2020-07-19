import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:redux/redux.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(tasks: taskReducer(state.tasks, action));
}

Reducer<List<TaskModel>> taskReducer = combineReducers<List<TaskModel>>([
  TypedReducer<List<TaskModel>, AddTaskAction>(addTaskReducer),
  TypedReducer<List<TaskModel>, TapTaskAction>(tapTaskReducer),
  TypedReducer<List<TaskModel>, LoadedTasksAction>(loadItemsReducer),
]);

List<TaskModel> addTaskReducer(List<TaskModel> tasks, AddTaskAction action) {
  return []
    ..addAll(tasks)
    ..add(TaskModel(id: tasks.length + 1, content: action.task.content));
}

List<TaskModel> tapTaskReducer(List<TaskModel> tasks, TapTaskAction action) {
  return tasks
      .map((TaskModel task) => task.id == action.taskId
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task)
      .toList();
}

List<TaskModel> loadItemsReducer(
    List<TaskModel> tasks, LoadedTasksAction action) {
  return action.tasks;
}
