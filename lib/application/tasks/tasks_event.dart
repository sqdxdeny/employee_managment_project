part of 'tasks_bloc.dart';

sealed class TasksEvent {
  const TasksEvent();

  const factory TasksEvent.loadTasks() = _LoadTasks;

  const factory TasksEvent.addTask(Task task) = _AddTask;

  const factory TasksEvent.deleteTask(String id) = _DeleteTask;

  const factory TasksEvent.setFilter (TaskFilter filter) = _SetFilter;

  const factory TasksEvent.setSort (TaskSort sort) = _SetSort;

  const factory TasksEvent.toggleTaskCompletion(String id) = _ToggleTaskCompletion;
}

class _LoadTasks extends TasksEvent {
  const _LoadTasks();
}

class _AddTask extends TasksEvent {
  final Task task;

  const _AddTask(this.task);
}

class _DeleteTask extends TasksEvent {
  final String id;
  const _DeleteTask(this.id);
}

class _SetFilter extends TasksEvent {
  final TaskFilter filter;
  const _SetFilter(this.filter);
}

class _SetSort extends TasksEvent {
  final TaskSort sort;
  const _SetSort(this.sort);
}

class _ToggleTaskCompletion extends TasksEvent {
  final String id;
  const _ToggleTaskCompletion(this.id);
}