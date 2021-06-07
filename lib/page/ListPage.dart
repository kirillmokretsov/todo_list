import 'package:flutter/material.dart';
import 'package:todo_list/database/HiveUtils.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var box = HiveUtils.getBox();

  Widget _buildTile(BuildContext context, int index) {
    Task? task = box.getAt(index);
    if (task != null)
      return ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (bool? value) => task.isCompleted = value!,
        ),
        title: Text(task.title),
      );
    else
      throw Exception('task at index $index is null');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemBuilder: _buildTile,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: box.length,
        padding: EdgeInsets.all(16.0),
      ),
    );
  }
}
