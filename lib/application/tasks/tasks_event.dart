part of 'tasks_bloc.dart';

sealed class TasksEvent {
  const TasksEvent();

  const factory TasksEvent.loadTasks() = _LoadTasks;

  const factory TasksEvent.addTask(Task task) = _AddTask;

  const factory TasksEvent.receiveTask(Task task) = _ReceiveTask;
}

class _LoadTasks extends TasksEvent {
  const _LoadTasks();
}

class _AddTask extends TasksEvent {
  final Task task;

  const _AddTask(this.task);
}

class _ReceiveTask extends TasksEvent {
  final Task task;

  const _ReceiveTask(this.task);
}
