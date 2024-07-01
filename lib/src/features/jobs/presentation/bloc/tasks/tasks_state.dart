part of 'tasks_bloc.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

class TasksLoading extends TasksState {}

class TasksDeleting extends TasksState {}

class TasksSending extends TasksState {}

class TasksLoaded extends TasksState {
  final bool tasksUpdated;
  final List<Task> tasks;
  final List<Task> selectedTasks;
  final List<Task> updatedTasks;

  const TasksLoaded({
    required this.tasks,
    this.selectedTasks = const [],
    this.tasksUpdated = false,
    this.updatedTasks = const [],
  });

  @override
  List<Object> get props => [
        tasks,
        selectedTasks,
        tasksUpdated,
        updatedTasks,
      ];

  TasksLoaded copyWith({
    List<Task>? tasks,
    List<Task>? selectedTasks,
    List<Task>? updatedTasks,
    bool? tasksUpdated,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
      updatedTasks: updatedTasks ?? this.updatedTasks,
      tasksUpdated: tasksUpdated ?? this.tasksUpdated,
    );
  }
}

class TasksError extends TasksState {
  final Failure failure;
  const TasksError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}
