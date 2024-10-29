import 'package:hive/hive.dart';
 
part 'task_model.g.dart';
 
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String task;
  bool completed = false;
  String description;
  Task({required this.task,  required this.completed, required this.description});
}