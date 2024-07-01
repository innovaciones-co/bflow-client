part of 'tasks_filter_bloc.dart';

sealed class TasksFilterEvent extends Equatable {
  const TasksFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TasksFilterEvent {}

class UpdateTasks extends TasksFilterEvent {
  final Set<TaskStatus> statusFilter;

  UpdateTasks({Set<TaskStatus>? statusFilter})
      : statusFilter = statusFilter ?? TaskStatus.values.toSet();

  @override
  List<Object> get props => [statusFilter];
}

class UpdateTabIndex extends TasksFilterEvent {
  final int tabIndex;

  const UpdateTabIndex({required this.tabIndex});

  @override
  List<Object> get props => [tabIndex];
}
