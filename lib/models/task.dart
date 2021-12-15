import 'package:hive/hive.dart';
part 'task.g.dart';
@HiveType(typeId:0)
class Task extends HiveObject{
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  List<String> subtasks;
  @HiveField(3)
  bool isCompleted;

  Task({required this.title, required this.description, required this.subtasks, required this.isCompleted});
}
