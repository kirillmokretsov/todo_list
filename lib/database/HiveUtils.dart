import 'package:hive/hive.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class HiveUtils {
  static final _tasksBoxName = 'tasks';

  static Box<Task>? _boxOfIncompleted;
  static Box<Task>? _boxOfCompleted;

  static Future<void> initBox() async {
    _boxOfIncompleted = await Hive.openBox(_tasksBoxName + '_incompleted');
    _boxOfCompleted = await Hive.openBox(_tasksBoxName + '_completed');
  }

  static Box<Task> getBox(bool isCompleted) {
    if (_boxOfCompleted == null || _boxOfIncompleted == null) {
      throw Exception('Need to initialize box firstly');
    } else {
      if (isCompleted)
        return _boxOfCompleted!;
      else
        return _boxOfIncompleted!;
    }
  }

  static void moveToAnotherBox(Task task, {required int indexOfDeleted}) {
    if (task.isCompleted) {
      _boxOfCompleted!.deleteAt(indexOfDeleted);
      task.isCompleted = false;
      _boxOfIncompleted!.add(task);
    } else {
      _boxOfIncompleted!.deleteAt(indexOfDeleted);
      task.isCompleted = true;
      _boxOfCompleted!.add(task);
    }
  }
}
