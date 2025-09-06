part of 'tasks_bloc.dart';

class TasksState with EquatableMixin {
  final List<Task> tasks;
  final bool isLoading;

  const TasksState({required this.tasks, required this.isLoading});

  factory TasksState.initial() => TasksState(tasks: [], isLoading: false);

  TasksState copyWith({List<Task>? tasks, bool? isLoading}) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [tasks, isLoading];
}
