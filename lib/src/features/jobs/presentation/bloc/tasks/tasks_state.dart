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
  final List<Task> updatedTasksData;
  final bool taskDataModified;
  final List<Contact> contacts;

  const TasksLoaded({
    required this.tasks,
    this.selectedTasks = const [],
    this.tasksUpdated = false,
    this.updatedTasks = const [],
    this.updatedTasksData = const [],
    this.taskDataModified = false,
    this.contacts = const [],
  });

  @override
  List<Object> get props => [
        tasks,
        selectedTasks,
        tasksUpdated,
        updatedTasks,
        updatedTasksData,
        taskDataModified,
        contacts,
      ];

  TasksLoaded copyWith({
    List<Task>? tasks,
    List<Task>? selectedTasks,
    List<Task>? updatedTasks,
    List<Task>? updatedTasksData,
    bool? taskDataModified,
    bool? tasksUpdated,
    List<Contact>? contacts,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
      updatedTasks: updatedTasks ?? this.updatedTasks,
      updatedTasksData: updatedTasksData ?? this.updatedTasksData,
      taskDataModified: taskDataModified ?? this.taskDataModified,
      tasksUpdated: tasksUpdated ?? this.tasksUpdated,
      contacts: contacts ?? this.contacts,
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
