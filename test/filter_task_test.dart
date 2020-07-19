import 'package:flutter_test/flutter_test.dart';
import 'package:manabietodo/models/task_model.dart';

void main() {
  group('Filter tasks complete and pending', () {
    test('list of pending tasks', () {
      final tasks = [
        TaskModel(id: 1, content: 'a'),
        TaskModel(id: 2, content: 'b'),
        TaskModel(id: 3, content: 'c', isCompleted: true),
      ];

      expect(getPendingTasks(tasks).length, 2);
      expect(getCompleteTasks(tasks).length, 1);
    });
  });
}
