import 'package:flutter/material.dart';
import 'package:todo_list/page/ListPage.dart';

void main() {
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
      home: ListPage(title: 'Todos'),
    );
  }
}
