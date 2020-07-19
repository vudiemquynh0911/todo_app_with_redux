import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/repository/task_repository.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> appStateMiddleware(
    {AppState state = const AppState(tasks: []), TasksRepository hive}) {
  final loadTasks = _loadFromHiveBox(state, hive);
  final saveTasks = _saveToHiveBox(state, hive);

  return [
    TypedMiddleware<AppState, AddTaskAction>(saveTasks),
    TypedMiddleware<AppState, TapTaskAction>(saveTasks),
    TypedMiddleware<AppState, GetTaskAction>(loadTasks),
  ];
}

Middleware<AppState> _loadFromHiveBox(AppState state, KeyValueStorage hive) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    hive
        .loadFromHiveBox()
        .then((tasks) => store.dispatch(LoadedTasksAction(tasks)));
  };
}

Middleware<AppState> _saveToHiveBox(AppState state, KeyValueStorage hive) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    hive.saveToHiveBox(store.state.tasks);
  };
}
