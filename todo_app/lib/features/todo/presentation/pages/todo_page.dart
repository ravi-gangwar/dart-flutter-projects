import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/features/todo/domain/todo_model.dart';
import 'package:todo_app/features/todo/presentation/provider/todo_provider.dart';
import 'package:todo_app/features/todo/presentation/widgets/todo_item.widget.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _addTodo() {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if(title.isEmpty) return;

    final todo = TodoModel.create(title: title, description: desc.isEmpty ? null : desc);
    ref.read(todoListProvider.notifier).addTodo(todo);

    _titleController.clear();
    _descController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          IconButton(onPressed: todos.isEmpty ? null : () => ref.read(todoListProvider.notifier).clearAll(), icon: const Icon(Icons.delete_forever), tooltip: 'Clear all',)
        ],
      ),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addTodo(),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _descController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addTodo(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: ElevatedButton.icon(onPressed: _addTodo, label: const Text('Add Todo'), icon: const Icon(Icons.add),))
                ],
              )
            ],
          ),
          ),
          const Divider(height: 1),
          Expanded(child: todos.isEmpty ? const Center(child: Text('NO todos yet add one above!'),)
          : ListView.separated(
            itemCount: todos.length,
            separatorBuilder: (_, __) => const Divider(height: 0,),
            itemBuilder: (context, index) {
              final t = todos[index];
              return TodoItemWidget(todo: t, onToggle: (id) => ref.read(todoListProvider.notifier).toggleComplete(id), onDelete: (id) => ref.read(todoListProvider.notifier).deleteTodo(id),);
            },
          ))
        ],
      ),
    );
  }
}