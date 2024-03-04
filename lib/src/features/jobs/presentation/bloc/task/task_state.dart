part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskError extends TaskState {
  final Failure failure;

  const TaskError({required this.failure});
}

final class TaskLoaded extends TaskState {
  final t.Task task;
  final Job job;

  const TaskLoaded({required this.job, required this.task});
}
