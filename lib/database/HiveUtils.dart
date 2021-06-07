import 'package:hive/hive.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class HiveUtils {
  static final _tasksBoxName = 'tasks';

  static Future<Box<Task>> getBox() async =>
      await Hive.openBox<Task>(_tasksBoxName);
}
