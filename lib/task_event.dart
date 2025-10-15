import 'package:equatable/equatable.dart';
import 'task.dart';
import 'homework_repository.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class LoadTasks extends TaskEvent {
  const LoadTasks({this.filter = Filter.all});

  final Filter filter;

  @override
  List<Object> get props => [filter];
}

final class AddTask extends TaskEvent {
  const AddTask(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

final class ToggleCompleted extends TaskEvent {
  const ToggleCompleted(this.task);

  final Task task;

  @override
  List<Object> get props => [task];
}

final class ChangeFilter extends TaskEvent {
  const ChangeFilter(this.filter);

  final Filter filter;

  @override
  List<Object> get props => [filter];
}