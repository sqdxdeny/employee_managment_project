// детали задачи
import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showTaskDetails(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
      title: Text(task.title ?? "Без названия"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Описание: ${task.description}"),
          const SizedBox(height: 8),
          Text("Автор: ${task.author}"),
          const SizedBox(height: 8),
          Text("Создано: ${DateFormat('dd.MM.yyyy HH:mm').format(task.createdAt)}"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Закрыть"),
        ),
      ],
    ),
  );
}