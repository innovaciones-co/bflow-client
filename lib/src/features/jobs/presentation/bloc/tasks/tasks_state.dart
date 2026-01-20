import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:equatable/equatable.dart';

class TasksState extends Equatable {
  final List<Task> allTasks;
  final List<Task> filteredTasks;
  final List<Task> selectedTasks;
  final List<Task> tasksUpdated;
  final List<Contact?> contacts;
  final String searchQuery;
  final TaskStatus? filterStatus;
  final TaskStage? filterStage;
  final bool isLoading;
  final bool isSending;
  final bool isDeleting;
  final Failure? error;

  const TasksState({
    this.allTasks = const [],
    this.filteredTasks = const [],
    this.selectedTasks = const [],
    this.tasksUpdated = const [],
    this.contacts = const [],
    this.searchQuery = '',
    this.filterStatus,
    this.filterStage,
    this.isLoading = false,
    this.isSending = false,
    this.isDeleting = false,
    this.error,
  });

  factory TasksState.initial() => const TasksState(
        allTasks: [],
        filteredTasks: [],
        selectedTasks: [],
        tasksUpdated: [],
        contacts: [],
        searchQuery: '',
        filterStatus: null,
        filterStage: null,
        isLoading: false,
        isSending: false,
        isDeleting: false,
        error: null,
      );

  TasksState copyWith({
    List<Task>? allTasks,
    List<Task>? filteredTasks,
    List<Task>? selectedTasks,
    List<Task>? tasksUpdated,
    List<Contact>? contacts,
    String? searchQuery,
    TaskStatus? filterStatus,
    TaskStage? filterStage,
    bool? isLoading,
    bool? isSending,
    bool? isDeleting,
    Failure? error,
  }) {
    return TasksState(
      allTasks: allTasks ?? this.allTasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      selectedTasks: selectedTasks ?? this.selectedTasks,
      tasksUpdated: tasksUpdated ?? this.tasksUpdated,
      contacts: contacts ?? this.contacts,
      searchQuery: searchQuery ?? this.searchQuery,
      filterStatus: filterStatus ?? this.filterStatus,
      filterStage: filterStage ?? this.filterStage,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      isDeleting: isDeleting ?? this.isDeleting,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        allTasks,
        filteredTasks,
        selectedTasks,
        tasksUpdated,
        contacts,
        searchQuery,
        filterStatus,
        filterStage,
        isLoading,
        isDeleting,
        isSending,
        error,
      ];
}
