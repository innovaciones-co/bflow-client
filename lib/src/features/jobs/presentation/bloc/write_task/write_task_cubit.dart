// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/upload_files_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/entities/purchase_order_entity.dart';
import 'package:bflow_client/src/features/purchase_orders/domain/usecases/get_purchase_orders_by_job_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_task_state.dart';

class WriteTaskCubit extends Cubit<WriteTaskState> {
  final t.Task? task;
  final GetContactsUseCase getContactsUseCase;
  final GetTasksUseCase getTasksUseCase;
  final CreateTaskUseCase createTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final UploadFilesUseCase uploadFilesUseCase;
  final GetPurchaseOrdersByJobUseCase getPurchaseOrdersByJobUseCase;
  final TasksBloc tasksBloc;
  final HomeBloc homeBloc;
  final JobBloc jobBloc;
  final JobsBloc jobsBloc;

  WriteTaskCubit({
    this.task,
    required this.getContactsUseCase,
    required this.getTasksUseCase,
    required this.createTasksUseCase,
    required this.updateTaskUseCase,
    required this.uploadFilesUseCase,
    required this.getPurchaseOrdersByJobUseCase,
    required this.tasksBloc,
    required this.homeBloc,
    required this.jobBloc,
    required this.jobsBloc,
  }) : super(
          WriteTaskCubitInitial(
            attachments: task?.attachments ?? [],
            description: task?.comments,
            endDate: task?.endDate,
            formStatus: FormStatus.initialized,
            name: task?.name ?? '',
            order: task?.order,
            parentTask: task?.parentTask,
            progress: task?.progress ?? 0,
            stage: task?.stage ?? TaskStage.slabDown,
            startDate: task?.startDate,
            status: task?.status ?? TaskStatus.created,
            supplier: task?.supplier,
            purchaseOrder: task?.purchaseOrder,
          ),
        );

  void initForm(int jobId) async {
    GetContactsParams getContactParams =
        GetContactsParams(contactType: ContactType.supplier);
    GetTasksParams tasksParams = GetTasksParams(jobId: jobId);
    GetPurchaseOrdersByJobParams getPurchaseOrdersByJobParams =
        GetPurchaseOrdersByJobParams(jobId: jobId);
    final suppliers = await getContactsUseCase.execute(getContactParams);
    final parentTasks = await getTasksUseCase.execute(tasksParams);
    final purchaseOrders = await getPurchaseOrdersByJobUseCase
        .execute(getPurchaseOrdersByJobParams);

    if (suppliers.isRight() &&
        parentTasks.isRight() &&
        purchaseOrders.isRight()) {
      List<Contact?> suppliersList = [
        null,
        ...suppliers.getOrElse(() => []),
      ];
      List<t.Task?> parentTasksList = [
        null,
        ...parentTasks.getOrElse(() => [])
      ];
      List<PurchaseOrder?> purchaseOrdersList = [
        null,
        ...purchaseOrders.getOrElse(() => [])
      ];
      emit(
        state.copyWith(
            suppliers: suppliersList,
            parentTasks: parentTasksList,
            formStatus: FormStatus.loaded,
            supplier: suppliersList.first,
            purchaseOrders: purchaseOrdersList),
      );
    } else {
      emit(state.copyWith(formStatus: FormStatus.loadFailed));
    }
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateProgress(String? progress) {
    int? intProgress = int.tryParse(progress ?? "0");
    emit(state.copyWith(progress: intProgress));
  }

  void updateStage(TaskStage? stage) {
    emit(state.copyWith(taskStage: stage));
  }

  void updateParentTask(t.Task? parentTask) {
    emit(state.copyWith(
        parentTask: parentTask?.id, taskStage: parentTask?.stage));
  }

  void updateSupplier(Contact? supplier) {
    emit(state.copyWith(supplier: supplier));
  }

  void updateDescription(String? description) {
    emit(state.copyWith(description: description));
  }

  void updateStartDate(DateTime? startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void updateEndDate(DateTime? endDate) {
    emit(state.copyWith(endDate: endDate));
  }

  void updateStatus(TaskStatus? status) {
    emit(state.copyWith(taskStatus: status));
  }

  void updatePurchaseOrder(PurchaseOrder? purchaseOrder) {
    emit(state.copyWith(purchaseOrder: purchaseOrder));
  }

  void createTask(int jobId) async {
    emit(state.copyWith(
      formStatus: FormStatus.inProgress,
    ));

    t.Task task = t.Task(
      name: state.name,
      status: state.status,
      stage: state.stage,
      job: jobId,
      startDate: state.startDate,
      endDate: state.endDate,
      comments: state.description,
      progress: state.progress,
      parentTask: state.parentTask,
      supplier: state.supplier,
      order: state.order,
      purchaseOrder: state.purchaseOrder,
    );

    var createdTask =
        await createTasksUseCase.execute(CreateTaskParams(task: task));

    createdTask.fold(
      (l) {
        emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
      },
      (r) {
        emit(state.copyWith(formStatus: FormStatus.success));
        tasksBloc.add(GetTasksEvent(jobId: task.job));
        homeBloc.add(ShowMessageEvent(
          message: "The task was added successfully!",
          type: AlertType.success,
        ));
      },
    );
  }

  void updateTask(t.Task newTask) async {
    //debugPrint(newTask.toString());
    emit(state.copyWith(
      formStatus: FormStatus.inProgress,
    ));

    t.Task task = newTask.copyWith(
      id: newTask.id,
      name: state.name,
      status: state.status,
      stage: state.stage,
      job: newTask.job,
      startDate: state.startDate,
      endDate: state.endDate,
      comments: state.description,
      progress: state.progress,
      parentTask: state.parentTask,
      supplier: state.supplier,
      attachments: state.attachments,
      order: state.order,
      purchaseOrder: state.purchaseOrder,
    );

    UploadFilesParams params = UploadFilesParams(files: state.attachments);
    final result = await uploadFilesUseCase.execute(params);

    result.fold(
      (failure) =>
          emit(state.copyWith(formStatus: FormStatus.failed, failure: failure)),
      (uploadedFiles) async {
        task = task.copyWith(attachments: uploadedFiles);
        var updateTask =
            await updateTaskUseCase.execute(UpdateTaskParams(task: task));

        updateTask.fold(
          (l) {
            emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
          },
          (r) {
            emit(state.copyWith(formStatus: FormStatus.success));
            tasksBloc.add(GetTasksEvent(jobId: task.job));
            homeBloc.add(ShowMessageEvent(
              message: "Task updated!",
              type: AlertType.success,
            ));
            jobsBloc.add(GetJobsEvent());
            jobBloc.add(GetJobEvent(id: newTask.job));
          },
        );
      },
    );
  }

  void updateAutovalidateMode(AutovalidateMode autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }

  void updateAttachments(List<File>? attachments) {
    emit(state.copyWith(attachments: attachments));
  }
}
