import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class ListPageOfDeleted extends StatelessWidget {

  final Box<Task> boxOfDeleted;
  final String title;

  const ListPageOfDeleted({Key? key, required this.boxOfDeleted, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.separated(
          itemBuilder: _buildTile,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: boxOfDeleted.length,
          padding: EdgeInsets.all(16.0),
        ),
      );
    }

  Widget _buildTile(BuildContext context, int index) {
      var task = boxOfDeleted.getAt(index);
      if (task != null) {
      return ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (value){},
          ),
          title: Text(task.title),
        );
    } else throw Exception('task at index $index is null');
  }
}
