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
  final List<Task> updatedTasks;
  final List<Contact?> contacts;
  final List<Task> tasksSearched;

  const TasksLoaded({
    required this.tasks,
    this.selectedTasks = const [],
    this.updatedTasks = const [],
    this.contacts = const [],
    this.tasksSearched = const [],
  });

  @override
  List<Object> get props => [
        tasks,
        selectedTasks,
        updatedTasks,
        contacts,
        tasksSearched,
      ];

  TasksLoaded copyWith({
    List<Task>? tasks,
    List<Task>? selectedTasks,
    List<Task>? updatedTasks,
    List<Contact?>? contacts,
    List<Task>? tasksSearched,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
      updatedTasks: updatedTasks ?? this.updatedTasks,
      contacts: contacts ?? this.contacts,
      tasksSearched: tasksSearched ?? this.tasksSearched,
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
