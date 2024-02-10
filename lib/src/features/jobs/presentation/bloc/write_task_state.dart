part of 'write_task_cubit.dart';

sealed class WriteTaskState extends Equatable {
  final AutovalidateMode autovalidateMode;
  final DateTime? endDate;
  final DateTime startDate;
  final Failure? failure;
  final FormStatus formStatus;
  final int progress;
  final List<Contact> suppliers;
  final Contact? supplier;
  final List<Task?> parentTasks;
  final String? description;
  final String name;
  final int? parentTask;
  final TaskStage taskStage;

  WriteTaskState({
    required this.parentTasks,
    DateTime? startDate,
    required this.suppliers,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.description,
    this.endDate,
    this.failure,
    this.formStatus = FormStatus.initialized,
    this.name = '',
    this.parentTask,
    this.progress = 0,
    this.supplier,
    this.taskStage = TaskStage.slabDown,
  }) : startDate = startDate ?? DateTime.now();

  WriteTaskState copyWith({
    AutovalidateMode? autovalidateMode,
    DateTime? endDate,
    DateTime? startDate,
    Failure? failure,
    FormStatus? formStatus,
    int? progress,
    Contact? supplier,
    String? description,
    String? name,
    int? parentTask,
    TaskStage? taskStage,
  });

  @override
  List<Object> get props => [
        autovalidateMode,
        endDate ?? '',
        startDate,
        failure ?? '',
        formStatus,
        progress,
        suppliers,
        supplier ?? '',
        parentTasks,
        description ?? '',
        name,
        parentTask ?? '',
        taskStage,
      ];
}

final class WriteTaskCubitInitial extends WriteTaskState {
  WriteTaskCubitInitial({
    required super.parentTasks,
    super.startDate,
    required super.suppliers,
    super.autovalidateMode,
    super.description,
    super.endDate,
    super.failure,
    super.formStatus,
    super.name,
    super.parentTask,
    super.progress,
    super.supplier,
    super.taskStage,
  });

  @override
  WriteTaskState copyWith({
    AutovalidateMode? autovalidateMode,
    DateTime? endDate,
    DateTime? startDate,
    Failure? failure,
    FormStatus? formStatus,
    int? progress,
    Contact? supplier,
    String? description,
    String? name,
    int? parentTask,
    TaskStage? taskStage,
  }) {
    return WriteTaskCubitInitial(
      parentTasks: parentTasks,
      startDate: startDate ?? this.startDate,
      suppliers: suppliers,
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      description: description ?? this.description,
      endDate: endDate ?? this.endDate,
      failure: failure ?? this.failure,
      formStatus: formStatus ?? this.formStatus,
      name: name ?? this.name,
      parentTask: parentTask ?? this.parentTask,
      progress: progress ?? this.progress,
      supplier: supplier ?? this.supplier,
      taskStage: taskStage ?? this.taskStage,
    );
  }
}
