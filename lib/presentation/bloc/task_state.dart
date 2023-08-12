part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);

  @override
  List<Object> get props => [message];
}

class TaskSuccess extends TaskState {
  final String result;
  const TaskSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class TaskHasData extends TaskState {
  final List<Tasks> task;

  const TaskHasData(this.task);

  @override
  List<Object> get props => [task];
}
