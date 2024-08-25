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
  final List<File> attachments;
  final String? description;
  final String name;
  final int? parentTask;
  final int? order;
  final List<PurchaseOrder?> purchaseOrders;
  final PurchaseOrder? purchaseOrder;
  final TaskStage stage;
  final TaskStatus status;

  WriteTaskState({
    this.parentTasks = const [],
    this.attachments = const [],
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
    this.order = 0,
    this.supplier,
    this.purchaseOrders = const [],
    this.purchaseOrder,
    this.stage = TaskStage.slabDown,
    this.status = TaskStatus.created,
  }) : startDate = startDate ?? DateTime.now();

  WriteTaskState copyWith({
    AutovalidateMode? autovalidateMode,
    Contact? supplier,
    DateTime? endDate,
    DateTime? startDate,
    Failure? failure,
    FormStatus? formStatus,
    int? order,
    int? parentTask,
    int? progress,
    List<Contact?>? suppliers,
    List<File>? attachments,
    List<t.Task?>? parentTasks,
    String? description,
    String? name,
    List<PurchaseOrder?>? purchaseOrders,
    PurchaseOrder? purchaseOrder,
    TaskStage? taskStage,
    TaskStatus? taskStatus,
  });

  @override
  List<Object> get props => [
        attachments,
        autovalidateMode,
        description ?? '',
        endDate ?? '',
        failure ?? '',
        formStatus,
        name,
        order ?? 0,
        parentTask ?? '',
        parentTasks,
        progress,
        purchaseOrder ?? '',
        purchaseOrders,
        stage,
        startDate,
        status,
        supplier ?? '',
        suppliers,
      ];
}

final class WriteTaskCubitInitial extends WriteTaskState {
  WriteTaskCubitInitial({
    super.attachments,
    super.autovalidateMode,
    super.description,
    super.endDate,
    super.failure,
    super.formStatus,
    super.name,
    super.order,
    super.parentTask,
    super.parentTasks,
    super.progress,
    super.purchaseOrder,
    super.purchaseOrders,
    super.stage,
    super.startDate,
    super.status,
    super.supplier,
    super.suppliers,
  });

  @override
  WriteTaskState copyWith({
    AutovalidateMode? autovalidateMode,
    Contact? supplier,
    DateTime? endDate,
    DateTime? startDate,
    Failure? failure,
    FormStatus? formStatus,
    int? order,
    int? parentTask,
    int? progress,
    List<Contact?>? suppliers,
    List<File>? attachments,
    List<t.Task?>? parentTasks,
    String? description,
    PurchaseOrder? purchaseOrder,
    List<PurchaseOrder?>? purchaseOrders,
    String? name,
    TaskStage? taskStage,
    TaskStatus? taskStatus,
  }) {
    return WriteTaskCubitInitial(
      parentTasks: parentTasks ?? this.parentTasks,
      attachments: attachments ?? this.attachments,
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
      purchaseOrder: purchaseOrder ?? this.purchaseOrder,
      purchaseOrders: purchaseOrders ?? this.purchaseOrders,
      stage: taskStage ?? stage,
      status: taskStatus ?? status,
      order: order ?? this.order,
    );
  }
}
