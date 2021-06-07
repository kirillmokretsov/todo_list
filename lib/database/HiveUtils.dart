import 'package:hive/hive.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class HiveUtils {
  static final _tasksBoxName = 'tasks';

  static bool _isBoxInit = false;

  static Future<void> initBox() async {
    _isBoxInit = true;
    await Hive.openBox(_tasksBoxName);
  }

  static Box<Task> getBox() {
    if (!_isBoxInit) {
      throw Exception('Need to initialize box firstly');
    } else {
      return Hive.box(_tasksBoxName);
    }
  }
}
