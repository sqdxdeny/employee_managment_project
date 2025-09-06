import 'dart:async';

import 'package:employee_managment_project/domain/tasks/task.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState.initial()) {
    on<_LoadTasks>(_loadTasks);
    on<_AddTask>(_addTask);
    on<_ReceiveTask>(_receiveTask);
  }

  Future<void> _loadTasks(_LoadTasks event, Emitter<TasksState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    emit(
      state.copyWith(
        isLoading: false,
        tasks: [
          Task(
            id: '1',
            title: 'First task',
            description: 'This is an example task',
            author: 'System',
            createdAt: DateTime.now(),
          ),
        ],
      ),
    );
  }

  Future<void> _addTask(_AddTask event, Emitter<TasksState> emit) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    emit(state.copyWith(tasks: updatedTasks));
  }

  Future<void> _receiveTask(
    _ReceiveTask event,
    Emitter<TasksState> emit,
  ) async {
    final updatedTasks = List<Task>.from(state.tasks)..add(event.task);
    emit(state.copyWith(tasks: updatedTasks));
  }
}
