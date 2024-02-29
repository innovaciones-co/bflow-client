part of 'write_task_cubit.dart';

sealed class WriteTaskState extends Equatable {
  final AutovalidateMode autovalidateMode;
  final DateTime? endDate;
  final DateTime startDate;
  final Failure? failure;
  final FormStatus formStatus;
  final int progress;
  final List<Contact?> suppliers;
  final Contact? supplier;
  final List<t.Task?> parentTasks;
  final String? description;
  final String name;
  final int? parentTask;
  final TaskStage taskStage;
  final TaskStatus taskStatus;

  WriteTaskState({
    this.parentTasks = const [],
    DateTime? startDate,
    this.suppliers = const [],
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
    this.taskStatus = TaskStatus.created,
  }) : startDate = startDate ?? DateTime.now();

  WriteTaskState copyWith({
    List<Contact?>? suppliers,
    List<t.Task?>? parentTasks,
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
    TaskStatus? taskStatus,
  });

  @override
  List<Object> get props => [
        autovalidateMode,
        description ?? '',
        endDate ?? '',
        failure ?? '',
        formStatus,
        name,
        parentTask ?? '',
        parentTasks,
        progress,
        startDate,
        supplier ?? '',
        suppliers,
        taskStage,
      ];
}

final class WriteTaskCubitInitial extends WriteTaskState {
  WriteTaskCubitInitial({
    super.parentTasks,
    super.startDate,
    super.suppliers,
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
    super.taskStatus,
  });

  @override
  WriteTaskState copyWith({
    List<Contact?>? suppliers,
    List<t.Task?>? parentTasks,
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
    TaskStatus? taskStatus,
  }) {
    return WriteTaskCubitInitial(
      parentTasks: parentTasks ?? this.parentTasks,
      startDate: startDate ?? this.startDate,
      suppliers: suppliers ?? this.suppliers,
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
      taskStatus: taskStatus ?? this.taskStatus,
    );
  }
}
