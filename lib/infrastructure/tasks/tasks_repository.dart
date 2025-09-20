import 'package:employee_managment_project/domain/tasks/task.dart';

final tasksRep = MockRep();

class MockRep {
  List<Task> _tasks = [
    Task(
      id: '1',
      title: 'First task',
      description: 'This is an example task',
      author: 'System',
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
  ];

  Future<List<Task>> loadTasks() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_tasks);
  }

  Future<void> addTask(Task task) async {
    _tasks = [..._tasks, task];
    await Future.delayed(const Duration(milliseconds: 300));
    return;
  }

  Future<void> deleteTask(String id) async {
    _tasks = _tasks.where((task) => task.id != id).toList();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> isCompleted(String id) async {
    _tasks = _tasks.map((e) {
      if (e.id == id) {
        return e.copyWith(isCompleted: !e.isCompleted);
      }
      return e;
    }).toList();
    await Future.delayed(const Duration(milliseconds: 300));
  }
}