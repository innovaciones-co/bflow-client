import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_task_state.dart';

class WriteTaskCubit extends Cubit<WriteTaskState> {
  final Task? task;
  final GetContactsUseCase getContactsUseCase;
  final GetTasksUseCase getTasksUseCase;

  WriteTaskCubit({
    required this.getContactsUseCase,
    required this.getTasksUseCase,
    this.task,
  }) : super(WriteTaskCubitInitial(
          name: task?.name ?? '',
          parentTask: task?.parentTask,
          taskStage: task?.stage ?? TaskStage.slabDown,
          supplier: task?.supplier,
          startDate: task?.startDate,
          endDate: task?.endDate,
          progress: task?.progress ?? 0,
          description: task?.comments,
        ));

  void initForm(int? jobId) async {
    GetContactsParams getContactParams =
        GetContactsParams(contactType: ContactType.supplier);
    GetTasksParams tasksParams = GetTasksParams(jobId: jobId);
    final suppliers = await getContactsUseCase.execute(getContactParams);
    final parentTasks = await getTasksUseCase.execute(tasksParams);

    if (suppliers.isRight() && parentTasks.isRight()) {
      List<Contact?> suppliersList = [null, ...suppliers.getOrElse(() => [])];
      List<Task?> parentTasksList = [null, ...parentTasks.getOrElse(() => [])];
      emit(
        state.copyWith(
          suppliers: suppliersList,
          parentTasks: parentTasksList,
          formStatus: FormStatus.loaded,
        ),
      );
    } else {
      emit(state.copyWith(formStatus: FormStatus.failed));
    }
  }

  void updateName(String? name) {
    emit(state.copyWith(name: name));
  }

  void updateProgress(String? progress) {
    int? intProgress = int.tryParse(progress ?? "");
    emit(state.copyWith(progress: intProgress));
  }

  void updateStage(TaskStage? stage) {
    emit(state.copyWith(taskStage: stage));
  }

  void updateParentTask(Task? parentTask) {
    emit(state.copyWith(parentTask: parentTask?.id));
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

  void createTask() {}
}
