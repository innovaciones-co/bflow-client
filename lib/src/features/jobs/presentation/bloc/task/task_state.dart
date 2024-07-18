part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskLoaded {
  const TaskLoading({required super.job, required super.task});
}

final class TaskError extends TaskState {
  final Failure failure;

  const TaskError({required this.failure});
}

enum TaskActionStatus {
  newTask,
  proposeDate,
  dateProposed,
  confirmTask,
  taskConfirmed,
  rejectTask,
  taskRejected,
  rescheduleTask,
  taskRescheduled,
  error,
  inProgress,
}

final class TaskLoaded extends TaskState {
  final t.Task task;
  final Job job;

  const TaskLoaded({
    required this.job,
    required this.task,
  });

  TaskLoaded copyWith({
    t.Task? task,
    Job? job,
  }) {
    return TaskLoaded(
      job: job ?? this.job,
      task: task ?? this.task,
    );
  }
}

final class TaskUpdated extends TaskLoaded implements Equatable {
  final TaskActionStatus actionStatus;
  final TaskAction? action;

  const TaskUpdated({
    this.action,
    this.actionStatus = TaskActionStatus.newTask,
    required super.job,
    required super.task,
  });

  @override
  TaskUpdated copyWith({
    t.Task? task,
    Job? job,
    TaskAction? action,
    TaskActionStatus? actionStatus,
  }) {
    return TaskUpdated(
      job: job ?? this.job,
      task: task ?? this.task,
      action: action ?? this.action,
      actionStatus: actionStatus ?? this.actionStatus,
    );
  }

  @override
  List<Object> get props => [job, task, action ?? "", actionStatus];
}
