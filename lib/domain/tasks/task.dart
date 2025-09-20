import 'package:equatable/equatable.dart';

class Task with EquatableMixin {
  final String id;
  final String? title;
  final String description;
  final String author;
  final DateTime createdAt;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? author,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }


  @override
  List<Object?> get props => [id, title, description, author, createdAt, isCompleted];
}

enum TaskFilter {all, open, completed}
enum TaskSort { byDateAsc, byDateDesc}
