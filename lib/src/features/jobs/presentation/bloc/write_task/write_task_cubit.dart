import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_task_state.dart';

class WriteTaskCubit extends Cubit<WriteTaskState> {
  final t.Task? task;
  final GetContactsUseCase getContactsUseCase;
  final GetTasksUseCase getTasksUseCase;
  final CreateTaskUseCase createTasksUseCase;
  final UpdateTaskUseCase updateTasksUseCase;
  final TasksBloc tasksBloc;
  final HomeBloc homeBloc;

  WriteTaskCubit({
    required this.getContactsUseCase,
    required this.getTasksUseCase,
    required this.createTasksUseCase,
    required this.updateTasksUseCase,
    required this.tasksBloc,
    required this.homeBloc,
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
      List<t.Task?> parentTasksList = [
        null,
        ...parentTasks.getOrElse(() => [])
      ];
      emit(
        state.copyWith(
          suppliers: suppliersList,
          parentTasks: parentTasksList,
          formStatus: FormStatus.loaded,
        ),
      );
    } else {
      emit(state.copyWith(formStatus: FormStatus.loadFailed));
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

  void createTask(int jobId) async {
    emit(state.copyWith(
      formStatus: FormStatus.inProgress,
    ));

    t.Task task = t.Task(
      name: state.name,
      status: state.taskStatus,
      stage: state.taskStage,
      job: jobId,
      startDate: state.startDate,
      endDate: state.endDate,
      comments: state.description,
      progress: state.progress,
      parentTask: state.parentTask,
      supplier: state.supplier,
    );

    var createdTask =
        await createTasksUseCase.execute(CreateTaskParams(task: task));

    createdTask.fold(
      (l) {
        emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
      },
      (r) {
        emit(state.copyWith(formStatus: FormStatus.success));
        tasksBloc.add(const GetTasksEvent());
        homeBloc.add(ShowMessageEvent(
          message: "Task added!",
          type: AlertType.success,
        ));
      },
    );
  }

  void updateTask(t.Task task) {}

  void updateAutovalidateMode(AutovalidateMode autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
