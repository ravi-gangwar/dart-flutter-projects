import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:todo_app/features/todo/domain/todo_model.dart';
import 'package:todo_app/features/todo/repository/todo_repository.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  throw UnimplementedError("Provide a TodoRepository in main");
});

class TodoListNotifier extends StateNotifier<List<TodoModel>> {
  final TodoRepository repository;
  TodoListNotifier(this.repository) : super([]) {
    _load();
  }

  void _load() {
    final todos = repository.getAllTodos();
    state = todos;
  }
  Future<void> _save() async {
    await repository.saveAll(state);
  }

  Future<void> addTodo(TodoModel todo) async {
    state = [todo, ...state];
    await _save();
  }

  Future<void> toggleComplete(String id) async {
    state = state.map((t) {
      if(t.id == id) return t.copyWith(completed: !t.completed);
      return t;
    }).toList();
    await _save();
  }

  Future<void> deleteTodo(String id) async {
    state = state.where((t) => t.id != id).toList();
    await _save();
  }

  Future<void> updateTodo(TodoModel updated) async { 
    state = state.map((t) => t.id == updated.id ? updated : t).toList();
    _save();
  }
  Future<void> clearAll() async {
    state = [];
    await _save();
  }
}

// provider 
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<TodoModel>> ((ref){
  final repo = ref.watch(todoRepositoryProvider);
  return TodoListNotifier(repo);
});