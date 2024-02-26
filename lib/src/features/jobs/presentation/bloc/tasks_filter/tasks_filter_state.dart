part of 'tasks_filter_bloc.dart';

sealed class TasksFilterState extends Equatable {
  const TasksFilterState();

  @override
  List<Object> get props => [];
}

final class TasksFilterLoading extends TasksFilterState {}

final class TasksFilterLoaded extends TasksFilterState {
  final List<Task> tasks;
  final Set<TaskStatus> statusFilter;

  TasksFilterLoaded({required this.tasks, Set<TaskStatus>? status})
      : statusFilter = status ?? TaskStatus.values.toSet();

  @override
  List<Object> get props => [tasks, statusFilter];
}
