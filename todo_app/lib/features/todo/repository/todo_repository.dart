import 'package:todo_app/features/todo/data/todo_local_datasource.dart';
import 'package:todo_app/features/todo/domain/todo_model.dart';

class TodoRepository {
  final TodoLocalDatasource localDatasource;
  TodoRepository(this.localDatasource);

  List<TodoModel> getAllTodos() {
    return localDatasource.loadTodos();
  }

  Future<void> saveAll(List<TodoModel> todos) async {
    await localDatasource.saveTodos(todos);
  }
}