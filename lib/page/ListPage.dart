import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/database/HiveUtils.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';
import 'package:todo_list/dialog/EditTaskDialog.dart';
import 'package:todo_list/widget/TasksList.dart';
import 'package:uuid/uuid.dart';

class ListPage extends StatefulWidget {
  final bool isCompleted;

  ListPage(this.isCompleted, {Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late Box<Task> box;

  @override
  void initState() {
    super.initState();
    box = HiveUtils.getBox(widget.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TasksList(widget.isCompleted),
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
}
