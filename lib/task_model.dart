import 'package:hive/hive.dart';
 
part 'task_model.g.dart';
 
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String task;
  @HiveField(1)
  bool completed = false;
  @HiveField(2)
  String description;
  Task({required this.task,  required this.completed, required this.description});
}