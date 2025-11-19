import 'dart:convert';

import 'package:todo_app/features/todo/domain/todo_model.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/core/storage/local_storage.dart' as LS;

class TodoLocalDatasource {
  final LS.LocalStorage storage;

  TodoLocalDatasource(this.storage);


  List<TodoModel>  loadTodos() {
    final raw = storage.readString(kTodosStorageKey);
    if(raw == null) return [];
    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => TodoModel.fromMap(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveTodos(List<TodoModel>  todos) async {
    final list = todos.map((t) => t.toMap()).toList();
    await storage.writeString(kTodosStorageKey, jsonEncode(list));
  }

  Future<void> clearTodods() async {
    await storage.remove(kTodosStorageKey);
  }

}