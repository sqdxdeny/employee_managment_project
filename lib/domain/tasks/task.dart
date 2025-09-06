import 'package:equatable/equatable.dart';

class Task with EquatableMixin {
  final String id;
  final String? title;
  final String description;
  final String author;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, author, createdAt];
}
