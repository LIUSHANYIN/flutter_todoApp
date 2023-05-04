import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  Todo({
    required this.title,
    required this.description,
    required this.point,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final String description;
  final int point;

 
}
