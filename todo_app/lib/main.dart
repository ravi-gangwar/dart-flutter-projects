// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/storage/local_storage.dart';
import 'features/todo/data/todo_local_datasource.dart';
import 'features/todo/repository/todo_repository.dart';
import 'features/todo/presentation/pages/todo_page.dart';
import 'features/todo/presentation/provider/todo_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize LocalStorage (SharedPreferences wrapper)
  final prefs = await SharedPreferences.getInstance();
  final localStorage = LocalStorage(prefs);

  // Setup datasource & repository
  final todoLocalDataSource = TodoLocalDatasource(localStorage);
  final todoRepository = TodoRepository(todoLocalDataSource);

  // Wrap the app with a ProviderScope and override the repository provider
  runApp(
    ProviderScope(
      overrides: [
        todoRepositoryProvider.overrideWithValue(todoRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoPage(),
    );
  }
}
