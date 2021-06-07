import 'package:flutter/material.dart';
import 'package:todo_list/database/HiveUtils.dart';

class ListPage extends StatefulWidget {
  ListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Widget _buildTile(BuildContext context, int index) => ListTile();

  @override
  Widget build(BuildContext context) {

    var box = HiveUtils.getBox();

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
