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
  final int tabIndex;

  TasksFilterLoaded({
    required this.tasks,
    Set<TaskStatus>? status,
    this.tabIndex = 0,
  }) : statusFilter = status ?? TaskStatus.values.toSet();

  @override
  List<Object> get props => [tasks, statusFilter, tabIndex];

  TasksFilterLoaded copyWith({
    List<Task>? tasks,
    Set<TaskStatus>? statusFilter,
    int? tabIndex,
  }) {
    return TasksFilterLoaded(
      tasks: tasks ?? this.tasks,
      status: statusFilter ?? this.statusFilter,
      tabIndex: tabIndex ?? this.tabIndex,
    );
  }
}
