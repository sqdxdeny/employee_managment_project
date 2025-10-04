part of 'tasks_bloc.dart';

class TasksState with EquatableMixin {
  final UnmodifiableListView<Task> tasks;
  final bool isLoading;
  final TaskFilter filter;
  final TaskSort sort;
  final DateTime lastUpdated;

  const TasksState({
    required this.tasks,
    required this.isLoading,
    required this.filter,
    required this.sort,
    required this.lastUpdated,
  });

  factory TasksState.initial() => TasksState(
    tasks: UnmodifiableListView([]),
    isLoading: false,
    filter: TaskFilter.all,
    sort: TaskSort.byDateDesc,
    lastUpdated: DateTime.now(),
  );

  TasksState copyWith({
    UnmodifiableListView<Task>? tasks,
    bool? isLoading,
    TaskFilter? filter,
    TaskSort? sort,
    DateTime? lastUpdated
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      filter: filter ?? this.filter,
      sort: sort ?? this.sort,
      lastUpdated: lastUpdated ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
    tasks,
    isLoading,
    filter,
    sort,
    lastUpdated,
  ];
}
