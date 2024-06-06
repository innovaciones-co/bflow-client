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
  final List<Task> tasks;
  final List<Task> selectedTasks;

  const TasksLoaded({
    required this.tasks,
    this.selectedTasks = const [],
  });

  @override
  List<Object> get props => [
        tasks,
        selectedTasks,
      ];

  TasksLoaded copyWith({
    List<Task>? tasks,
    List<Task>? selectedTasks,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
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
