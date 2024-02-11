import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_task_state.dart';

class WriteTaskCubit extends Cubit<WriteTaskState> {
  final List<Contact> suppliers;
  final List<Task?> tasks;
  final Task? task;

  WriteTaskCubit({
    required this.tasks,
    required this.suppliers,
    this.task,
  }) : super(WriteTaskCubitInitial(
          parentTasks: tasks,
          suppliers: suppliers,
          name: task?.name ?? '',
          parentTask: task?.parentTask,
          taskStage: task?.stage ?? TaskStage.slabDown,
          supplier: task?.supplier,
          startDate: task?.startDate,
          endDate: task?.endDate,
          progress: task?.progress ?? 0,
          description: task?.comments,
        ));

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
}
