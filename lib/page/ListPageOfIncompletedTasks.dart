import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/HiveUtils.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';
import 'package:todo_list/dialog/EditTaskDialog.dart';
import 'package:todo_list/page/ListPageOfCompletedTasks.dart';
import 'package:todo_list/widget/TasksList.dart';
import 'package:uuid/uuid.dart';

import 'MyAboutPage.dart';

class ListPageOfIncompletedTasks extends StatefulWidget {
  ListPageOfIncompletedTasks({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageOfIncompletedTasksState createState() =>
      _ListPageOfIncompletedTasksState();
}

class _ListPageOfIncompletedTasksState
    extends State<ListPageOfIncompletedTasks> {
  late Box<Task> box;

  @override
  void initState() {
    super.initState();
    box = HiveUtils.getBox(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _showSaved,
            icon: Icon(Icons.list),
          ),
          IconButton(
            onPressed: () => MyAboutPage.showAbout(context),
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: TasksList(false),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTask() async {
    final result = await showDialog(
      context: context,
      builder: (context) => EditTaskDialog(
        Task(
          id: Uuid().v4(),
          title: '',
          timeAdded: DateTime.now().millisecondsSinceEpoch,
          timeEdited: DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );
    if (result is Task) {
      box.add(result);
    }
    setState(() {});
  }

  void _showSaved() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ListPageOfCompletedTasks(title: widget.title),
      ),
    );
    setState(() {
      // If user makes task incompleted then show it in list of incompleted
    });
  }
}
