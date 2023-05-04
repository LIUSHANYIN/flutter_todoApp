import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Color.fromARGB(255, 79, (todo.point / 5 * 155).round() + 100, 149),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(todo.title),
            Text(todo.description),
          ],
        ),
      ),
    );
  }
}
