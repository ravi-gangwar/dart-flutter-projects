import 'package:flutter/material.dart';
import 'package:todo_app/features/todo/domain/todo_model.dart';

typedef OnToggle = void Function(String id);
typedef OnDelete = void Function(String id);


class TodoItemWidget extends StatelessWidget {
  final TodoModel todo;
  final OnToggle onToggle;
  final OnDelete onDelete;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(Icons.delete, color: Colors.white,),
      ),
      child: ListTile(
        leading: Checkbox(value: todo.completed, 
        onChanged: (_) => onToggle(todo.id)),
      title: Text(
        todo.title,
        style: todo.completed 
        ? const TextStyle(decoration: TextDecoration.lineThrough) 
        : null,
      ),
      subtitle: todo.description != null ? Text(todo.description!) : null,
      ),
    );
  }
}