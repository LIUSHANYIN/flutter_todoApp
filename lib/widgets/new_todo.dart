import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/models/todo.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key, required this.addNewTodo});
  final void Function(Todo item) addNewTodo;
  @override
  State<NewTodo> createState() {
    // TODO: implement createState
    return _NewTodoState();
  }
}

class _NewTodoState extends State<NewTodo> {
  final List<int> _points = [1, 2, 3, 4, 5];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int? _point;

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('输入违规'),
          content: const Text('请确保你输入了标题，选择了优先级，输入了描述！'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('了解'))
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('输入违规'),
          content: const Text('请确保你输入了标题，选择了优先级，输入了描述！'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('了解'))
          ],
        ),
      );
    }
  }

  void _submitTodo() {
    final pointIsInValid = _point == null || _point! <= 0;
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        pointIsInValid) {
      _showDialog();
      return;
    }
    final title = _titleController.text;
    final description = _descriptionController.text;
    final point = _point;
    widget.addNewTodo(
        Todo(title: title, description: description, point: point!));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    // TODO: implement build
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 40, 16, keyboardSpace + 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _titleController,
                      keyboardType: TextInputType.text,
                      maxLength: 10,
                      decoration: const InputDecoration(label: Text('标题')),
                    ),
                  ),
                  const Spacer(),
                  Row(children: [
                    const Text('优先级:'),
                    const SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                        value: _point,
                        items: _points
                            .map(
                              (a) => DropdownMenuItem(
                                value: a,
                                child: Text('$a'),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _point = value;
                          });
                        })
                  ]),
                ],
              ),
              // Expanded(
              //   child: TextField(
              //     controller: _descriptionController,
              //     maxLength: 50,
              //     decoration: const InputDecoration(label: Text('任务描述')),
              //   ),
              // ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      decoration: const InputDecoration(label: Text('任务描述')),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('退出'),
                  ),
                  ElevatedButton(
                    onPressed: _submitTodo,
                    child: const Text('提交'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
