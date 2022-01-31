import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/HiveUtils.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';
import 'package:todo_list/dialog/EditTaskDialog.dart';

class TasksList extends StatefulWidget {
  final bool isCompleted;

  const TasksList(this.isCompleted, {Key? key}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late Box<Task> box;

  @override
  void initState() {
    super.initState();
    box = HiveUtils.getBox(widget.isCompleted);
  }

  Widget _buildTile(BuildContext context, int index) {
    Task? task = box.getAt(index);
    if (task != null)
      return Dismissible(
        key: UniqueKey(),
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              HiveUtils.moveToAnotherBox(task!, indexOfDeleted: index);
              setState(() {});
            },
          ),
          title: Text(task.title),
        ),
        background: Container(
          color: Colors.green,
          child: Icon(Icons.edit),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: Icon(Icons.delete),
        ),
        onDismissed: (direction) async {
          if (direction == DismissDirection.endToStart) {
            HiveUtils.deleteTask(
              task!,
              indexOfDeleted: index,
            );
          } else if (direction == DismissDirection.startToEnd) {
            final result = await showDialog(
              context: context,
              builder: (context) => EditTaskDialog(task!),
            );
            if (result is Task) {
              box.putAt(index, result);
              task = result;
              setState(() {});
            }
          }
        },
      );
    else
      throw Exception('task at index $index is null');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: _buildTile,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: box.length,
      padding: EdgeInsets.all(16.0),
    );
  }

}
