import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/models/task_model.dart';
import 'package:manabietodo/redux/actions.dart';
import 'package:manabietodo/redux/middleware.dart';
import 'package:manabietodo/redux/reducers.dart';
import 'package:manabietodo/repository/task_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';

class MockTaskRepository extends Mock implements KeyValueStorage {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('Middleware testing', () {
    test('should load the tasks in response to Get Task Action', () {
      final repository = MockTaskRepository();
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initState(),
        middleware: appStateMiddleware(hive: repository),
      );
      final tasks = [TaskModel(id: 1, content: 'My Task')];

      when(repository.loadFromHiveBox()).thenAnswer((_) => Future.value(tasks));

      store.dispatch(GetTaskAction());

      verify(repository.loadFromHiveBox());
    });

    test('should save the state on every update action', () {
      final repository = MockTaskRepository();
      final store = Store<AppState>(
        appStateReducer,
        initialState: AppState.initState(),
        middleware: appStateMiddleware(hive: repository),
      );
      final task = TaskModel(id: 1, content: 'My Task');

      store.dispatch(AddTaskAction(task));
      // tap to update it to complete task
      store.dispatch(TapTaskAction(task.id));
      // tap to make it to incomplete task
      store.dispatch(TapTaskAction(task.id));
      verify(repository.saveToHiveBox(any)).called(3);
    });
  });
}
