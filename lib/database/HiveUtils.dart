import 'package:hive/hive.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class HiveUtils {
  static final _tasksBoxName = 'tasks';

  static Box<Task>? _box;

  static Future<void> initBox() async =>
      _box = await Hive.openBox(_tasksBoxName);

  static Box<Task> getBox(bool isCompleted) {
    if (_box != null) {
      return _box!;
    } else {
      throw Exception('Need to initialize box firstly');
    }
  }
}
