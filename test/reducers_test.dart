import 'package:flutter_test/flutter_test.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/redux/reducers.dart';
import 'package:redux/redux.dart';

void main() {
  group('State Reducer', () {
    test('Add new task by AddTaskAction', () {
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initState(),
      );
      final task = TaskModel(id: 1, content: 'My new task');

      store.dispatch(AddTaskAction(task));
      expect(store.state.tasks, [task]);
    });

    test('Complete task by TapTaskAction', () {
      final task = TaskModel(id: 1, content: 'Tap to complete');
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initState(),
      );

      store.dispatch(AddTaskAction(task));
      store.dispatch(TapTaskAction(task.id));

      expect(
          store.state.tasks
              .firstWhere((element) => element.id == task.id)
              .isCompleted,
          isTrue);
    });

    test('Uncheck done task by TapTaskAction', () {
      final task = TaskModel(id: 1, content: 'Tap to complete');
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initState(),
      );

      store.dispatch(AddTaskAction(task));
      store.dispatch(TapTaskAction(task.id));
      store.dispatch(TapTaskAction(task.id));

      expect(
          store.state.tasks
              .firstWhere((element) => element.id == task.id)
              .isCompleted,
          isFalse);
    });
  });
}
