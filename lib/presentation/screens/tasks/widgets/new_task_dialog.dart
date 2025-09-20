// Окно добавления новой задачи
import 'package:employee_managment_project/application/tasks/tasks_bloc.dart';
import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showAddTaskDialog(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final authorController = TextEditingController();

  showDialog(
    context: context,
    builder: (dialogContext) {
      return BlocProvider.value(
        value: context.read<TasksBloc>(),
        child: AlertDialog(
          title: const Text('New Task'),
          content: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                final task = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  author: authorController.text,
                  createdAt: DateTime.now(),
                  isCompleted: false, // ✅ всегда новая — незавершенная
                );
                context.read<TasksBloc>().add(TasksEvent.addTask(task));
                Navigator.pop(dialogContext);
              },
            ),
          ],
        ),
      );
    },
  );
}