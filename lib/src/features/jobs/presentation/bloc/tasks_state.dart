part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  const TasksLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskError extends TasksState {
  final Failure failure;
  const TaskError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
