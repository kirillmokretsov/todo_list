import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int timeAdded;

  @HiveField(3)
  int timeEdited;

  @HiveField(4)
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.timeAdded,
    required this.timeEdited,
    this.isCompleted: false,
  });
}
