import 'package:hive/hive.dart';
import 'package:manabietodo/models/app_state.dart';
import 'package:manabietodo/models/task_model.dart';

abstract class TasksRepository {
  Future<List<TaskModel>> loadFromHiveBox();

  Future saveToHiveBox(List<TaskModel> tasks);
}

const String TASK_BOX = "TASK_BOX";
const String TASK_KEY = "TASK_LIST";

class KeyValueStorage implements TasksRepository {
  @override
  Future<List<TaskModel>> loadFromHiveBox() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    String tasksStr = preferences.getString(TASK_KEY);
//    if(tasksStr != null && tasksStr.isNotEmpty) {
//      Map map = json.decode(tasksStr);
//      return AppState.fromJson(map).tasks;
//    }
//    return AppState.initState().tasks;
    final box = await Hive.openBox(TASK_BOX);
    Map<dynamic, dynamic> tasksFromBox = box.get(TASK_KEY);
    if (tasksFromBox != null && tasksFromBox['tasks'] != null) {
      try {
        var taskGet = List<TaskModel>.from(tasksFromBox['tasks']);
        return AppState(tasks: List.unmodifiable(taskGet)).tasks;
      } catch (e) {
        print("Error" + e.toString());
        return AppState.initState().tasks;
      }
    } else {
      return AppState.initState().tasks;
    }
  }

  @override
  Future saveToHiveBox(List<TaskModel> tasks) async {
    final box = await Hive.openBox(TASK_BOX);
    final taskList = {"tasks": tasks};
    box.put(TASK_KEY, taskList);
  }
}
