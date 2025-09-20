import 'dart:async';
import 'dart:collection';

import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:employee_managment_project/infrastructure/tasks/tasks_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState.initial()) {
    on<_LoadTasks>(_loadTasks);
    on<_AddTask>(_addTask);
    on<_DeleteTask>(_deleteTask);
    on<_SetFilter>(_setFilter);
    on<_SetSort>(_setSort);
    on<_ToggleTaskCompletion>(_toggleTaskCompletion);
    add(TasksEvent.loadTasks());
  }

  Future<void> _loadTasks(_LoadTasks event, Emitter<TasksState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final loaded = await tasksRep.loadTasks();
    // новый UnmodifiableListView
    final newTasks = UnmodifiableListView(loaded);
    emit(
      state.copyWith(
        isLoading: false,
        tasks: newTasks,
      ),
    );
  }

  Future<void> _toggleTaskCompletion(_ToggleTaskCompletion event, Emitter<TasksState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    await tasksRep.isCompleted(event.id);
    // update
    final updatedTasks = state.tasks.map(
      (task) => task.id == event.id ? task.copyWith(isCompleted: !task.isCompleted) : task,
    );

    emit(
      state.copyWith(
        isLoading: false,
        tasks: UnmodifiableListView(
          updatedTasks,
        ),
      ),
    );
  }

  Future<void> _addTask(_AddTask event, Emitter<TasksState> emit) async {
    emit(state.copyWith(isLoading: true));
    await tasksRep.addTask(event.task);
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    emit(state.copyWith(isLoading: false, tasks: UnmodifiableListView(updatedTasks)));
  }

  Future<void> _deleteTask(_DeleteTask event, Emitter<TasksState> emit) async {
    emit(state.copyWith(isLoading: true));
    await tasksRep.deleteTask(event.id);
    final updatedTasks = state.tasks.where((task) => task.id != event.id).toList();
    emit(state.copyWith(isLoading: false, tasks: UnmodifiableListView(updatedTasks)));
  }

  void _setFilter(_SetFilter event, Emitter<TasksState> emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  void _setSort(_SetSort event, Emitter<TasksState> emit) {
    emit(state.copyWith(sort: event.sort));
  }
}
