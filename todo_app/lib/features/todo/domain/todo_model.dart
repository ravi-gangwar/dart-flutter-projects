import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String? description;
  final bool completed;
  final DateTime createdAt;

  TodoModel(
    {
      required this.id, 
      required this.title, 
      this.description, 
      this.completed = false, 
      DateTime? createdAt
    }) : createdAt = createdAt ?? DateTime.now();

    factory TodoModel.create({
      required String title, 
      String? description
    }){
      return TodoModel(id: const Uuid().v4(), title: title);
    }

  TodoModel copyWith({
    String? id, 
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt, 
  }){
    return TodoModel(id: id ?? this.id, title: title ?? this.title, description: description ?? this.description, completed: completed ?? this.completed, createdAt: createdAt ?? this.createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description' : completed,
      'createdAt' : createdAt.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(id: map['id'] as String, title: map['title'] as String, description: map['description']  as String?, completed: map['completed']  as bool? ?? false, createdAt: DateTime.parse(map['createdAt'] as String),);
  }
}