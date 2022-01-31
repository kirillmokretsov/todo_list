import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/database/HiveUtils.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';
import 'package:todo_list/page/ListPageOfIncompletedTasks.dart';

// TODO: add ability to sort tasks: by name, by time of creation, by time of editing

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await HiveUtils.initBox();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent,
      ),
      home: ListPageOfIncompletedTasks(title: 'Todos'),
    );
  }
}
