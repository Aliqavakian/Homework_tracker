import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'homework_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc({required HomeworkRepository repository})
      : _repository = repository,
        super(const TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<ToggleCompleted>(_onToggleCompleted);
    on<ChangeFilter>(_onChangeFilter);
  }

  final HomeworkRepository _repository;

  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final tasks = await _repository.fetchAll(filter: event.filter);
      emit(state.copyWith(
        tasks: tasks,
        loading: false,
        filter: event.filter,
      ));
    } catch (error) {
      emit(state.copyWith(
        loading: false,
        error: error.toString(),
      ));
    }
  }

  Future<void> _onAddTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    try {
      await _repository.insert(event.task);
      add(LoadTasks(filter: state.filter));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> _onToggleCompleted(
    ToggleCompleted event,
    Emitter<TaskState> emit,
  ) async {
    if (event.task.id == null) return;
    
    try {
      await _repository.updateCompleted(
        event.task.id!,
        !event.task.completed,
      );
      add(LoadTasks(filter: state.filter));
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
    }
  }

  Future<void> _onChangeFilter(
    ChangeFilter event,
    Emitter<TaskState> emit,
  ) async {
    add(LoadTasks(filter: event.filter));
  }
}