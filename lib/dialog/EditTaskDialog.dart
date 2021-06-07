import 'package:flutter/material.dart';
import 'package:todo_list/datamodel/TaskDataModel.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;

  const EditTaskDialog(this.task, {Key? key}) : super(key: key);

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.task.title;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter new task'),
      content: Form(
        key: _key,
        child: TextFormField(
          initialValue: title,
          onChanged: (value) {
            title = value;
            setState(() {});
          },
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty)
              return 'Title must not be empty';
            else
              return null;
          },
          onEditingComplete: _save,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _save,
          child: Text('Save'),
        )
      ],
    );
  }

  void _save() {
    if (_key.currentState!.validate()) {
      widget.task.title = title;
      Navigator.pop(context, widget.task);
    }
  }
}
