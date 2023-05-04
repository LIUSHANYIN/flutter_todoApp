import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_list/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todoData, required this.deleteTodo});

  final List<Todo> todoData;
  final void Function(Todo todoItem) deleteTodo;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: todoData.length,
      itemBuilder: (ctx, index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Dismissible(
          background: Container(
            color: Colors.red,
            child: Row(children: const [
              Icon(
                Icons.delete,
                size: 45,
              ),
              Spacer(),
              Text('删除'),
              Spacer(),
              Icon(
                Icons.delete,
                size: 45,
              ),
            ]),
          ),
          key: ValueKey(todoData[index]),
          onDismissed: (direction) {
            deleteTodo(todoData[index]);
          },
          child: SizedBox(
            width: double.infinity,
            child: TodoItem(todo: todoData[index]),
          ),
        ),
      ),
    );
  }
}
