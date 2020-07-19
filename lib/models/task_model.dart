import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String content;

  @HiveField(2)
  bool isCompleted;

  TaskModel({this.id, this.content, this.isCompleted = false});

  TaskModel copyWith({int id, String content, bool isCompleted}) {
    return TaskModel(
        id: id ?? this.id,
        content: content ?? this.content,
        isCompleted: isCompleted ?? this.isCompleted);
  }

  TaskModel.fromJson(Map jsonMap) :
      id = jsonMap['id'],
      content = jsonMap['content'],
      isCompleted = jsonMap['is_complete'];

  Map toJson() => {
    'id' : id,
    'content' : content,
    'is_complete' : isCompleted
  };

  @override
  int get hashCode =>
      isCompleted.hashCode ^ content.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TaskModel &&
              runtimeType == other.runtimeType &&
              isCompleted == other.isCompleted &&
              content == other.content &&
              id == other.id;
}

List<TaskModel> getCompleteTasks (List<TaskModel> taskList) {
  return taskList.where((task) => task.isCompleted).toList();
}

List<TaskModel> getPendingTasks (List<TaskModel> taskList) {
  return taskList.where((task) => !task.isCompleted).toList();
}
