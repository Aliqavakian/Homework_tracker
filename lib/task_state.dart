import 'package:equatable/equatable.dart';
import 'task.dart';
import 'homework_repository.dart';

final class TaskState extends Equatable {
  const TaskState({
    this.tasks = const <Task>[],
    this.loading = false,
    this.error,
    this.filter = Filter.all,
  });

  final List<Task> tasks;
  final bool loading;
  final String? error;
  final Filter filter;

  TaskState copyWith({
    List<Task>? tasks,
    bool? loading,
    String? error,
    Filter? filter,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [tasks, loading, error, filter];
}