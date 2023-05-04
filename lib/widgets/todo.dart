import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/new_todo.dart';
import 'package:todo_app/widgets/todo_list/todo_list.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});
  @override
  State<Todos> createState() {
    // TODO: implement createState
    return _TodoState();
  }
}

class _TodoState extends State<Todos> {
  final List<Todo> _initialTodoList = [
    Todo(
        title: '图片上传',
        description: '链接aws s3云盘实现用户上传图片功能，并且限制图片尺寸和格式',
        point: 2),
    Todo(title: '登录系统', description: '创建用户登录注册，手机注册验证', point: 5),
    Todo(title: '短信服务', description: '链接vonage实现验证短信以及短信营销和提醒服务', point: 4),
    Todo(title: '地图导航', description: '利用Google map api接口实现位置导航', point: 3),
  ];

  List<Todo> _getSortedTodos() {
    late List<Todo> arr = _initialTodoList;
    arr.sort((a, b) => b.point.compareTo(a.point));
    return arr;
  }

  void _addNewTodo(Todo item) {
    setState(() {
      _initialTodoList.add(item);
    });
  }

  void _addTodo() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewTodo(addNewTodo: _addNewTodo),
    );
  }

  void _deleteTodo(Todo todoItem) {
    final currentIndex = _getSortedTodos().indexOf(todoItem);
    setState(() {
      _getSortedTodos().removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: '撤回',
            onPressed: () {
              setState(() {
                _getSortedTodos().insert(currentIndex, todoItem);
              });
            }),
        content: const Text('成功删除!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget mainContent = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [Text('No Todo Found!'), Text('Start Adding Some!')],
      ),
    );
    if (_getSortedTodos().isNotEmpty) {
      mainContent =
          TodoList(todoData: _getSortedTodos(), deleteTodo: _deleteTodo);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('任务列表'),
        actions: [
          IconButton(
            onPressed: _addTodo,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: mainContent,
    );
  }
}
