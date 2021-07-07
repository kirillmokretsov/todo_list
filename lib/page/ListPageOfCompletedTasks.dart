import 'package:flutter/material.dart';
import 'package:todo_list/widget/TasksList.dart';

class ListPageOfCompletedTasks extends StatefulWidget {

  ListPageOfCompletedTasks({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageOfCompletedTasksState createState() => _ListPageOfCompletedTasksState();
}

class _ListPageOfCompletedTasksState extends State<ListPageOfCompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TasksList(true),
    );
  }
}
