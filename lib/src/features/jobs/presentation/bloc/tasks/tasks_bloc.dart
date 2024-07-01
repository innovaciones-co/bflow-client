// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/send_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final JobBloc jobBloc;
  final GetTasksUseCase getTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final SendTasksUseCase sendTasksUseCase;
  final UpdateTasksUseCase updateTasksUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final GetContactsUseCase getContactsUseCase;
  final HomeBloc? homeBloc;
  final SocketService socketService;
  List<Task> tasks = [];

  TasksBloc({
    required this.jobBloc,
    required this.getTasksUseCase,
    required this.deleteTaskUseCase,
    required this.sendTasksUseCase,
    required this.updateTasksUseCase,
    required this.updateTaskUseCase,
    required this.getContactsUseCase,
    required this.homeBloc,
    required this.socketService,
  }) : super(TasksInitial()) {
    socketService.init();
    socketService.addSubscription(
      SocketSubscription(
        topic: SocketConstants.tasksTopic,
        callback: (_) {
          if (jobBloc.state is JobLoaded) {
            add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
          }
        },
      ),
    );

    on<UpdateTasksEvent>(_updateTasks);
    on<DeleteTasksEvent>(_deleteTasks);
    on<ToggleSelectedTask>(_toggleSelectedTask);
    on<AddSelectedTask>(_addSelectedTask);
    on<RemoveSelectedTask>(_removeSelectedTask);
    on<SendTaskEvent>(_sendTask);
    on<SendSelectedTasksEvent>(_sendTasks);
    on<TasksEvent>((event, emit) {});
    on<LoadingTasksEvent>(_loadingTasks);
    on<GetTasksEvent>(_getTasks);
    on<UpdateTaskDataEvent>(_updateTaskData);
    on<SaveUpdatedTasks>(_saveUpdatedTasks);

    if (jobBloc.state is JobLoaded) {
      add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
    }
  }

  FutureOr<void> _sendTasks(event, emit) async {
    if (state is TasksLoaded) {
      var loadedState = (state as TasksLoaded);
      var selectedTasks = List<Task>.from(loadedState.selectedTasks);

      emit(TasksSending());

      var task =
          await sendTasksUseCase.execute(SendTasksParams(tasks: selectedTasks));
      task.fold(
        (failure) {
          homeBloc?.add(
            ShowMessageEvent(
                message:
                    "There was a failure sending the tasks: ${failure.message}",
                type: AlertType.error),
          );
          emit(loadedState);
        },
        (r) {
          homeBloc?.add(
            ShowMessageEvent(
                message:
                    "A confirmation email was sent for the suppliers of the selected tasks.",
                type: AlertType.success),
          );
          add(GetTasksEvent(jobId: loadedState.tasks.first.job));
        },
      );
    }
  }

  FutureOr<void> _deleteTasks(event, emit) async {
    if (state is TasksLoaded) {
      var loadedState = (state as TasksLoaded);
      var selectedTasks = List<Task>.from(loadedState.selectedTasks);

      emit(TasksDeleting());

      for (var e in selectedTasks) {
        var task = await deleteTaskUseCase.execute(DeleteTaskParams(id: e.id!));
        task.fold(
          (failure) {
            homeBloc?.add(
              ShowMessageEvent(
                  message:
                      "Task ${e.id} couldn't be deleted: ${failure.message}",
                  type: AlertType.error),
            );
            emit(loadedState);
          },
          (r) {
            add(GetTasksEvent(jobId: e.job));
          },
        );
      }
    }
  }

  FutureOr<void> _toggleSelectedTask(event, emit) {
    if (state is TasksLoaded) {
      var loadedState = (state as TasksLoaded);
      var selectedTasks = List<Task>.from(loadedState.selectedTasks);
      var task = event.task;

      if (selectedTasks.contains(task)) {
        selectedTasks.remove(task);
      } else {
        selectedTasks.add(task);
      }

      emit(
        loadedState.copyWith(selectedTasks: selectedTasks),
      );
    }
  }

  _getTasks(GetTasksEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());

    GetTasksParams taskParams = GetTasksParams(jobId: event.jobId);
    var tasksOrFailure = await getTasksUseCase.execute(taskParams);
    GetContactsParams contactParams =
        GetContactsParams(contactType: ContactType.supplier);
    var suppliersOrFailure = await getContactsUseCase.execute(contactParams);

    suppliersOrFailure.fold(
      (l) => emit(TasksError(failure: l)),
      (s) {
        tasksOrFailure.fold(
          (l) => emit(TasksError(failure: l)),
          (t) {
            t.sort((a, b) => a.order - b.order);
            emit(TasksLoaded(tasks: t, contacts: s));
          },
        );
      },
    );
  }

  FutureOr<void> _loadingTasks(
      LoadingTasksEvent event, Emitter<TasksState> emit) {
    emit(TasksLoading());
  }

  FutureOr<void> _removeSelectedTask(
      RemoveSelectedTask event, Emitter<TasksState> emit) {
    var loadedState = (state as TasksLoaded);
    var selectedTasks = List<Task>.from(loadedState.selectedTasks);
    var task = event.task;

    emit(TasksDeleting());

    selectedTasks.remove(task);

    emit(
      loadedState.copyWith(selectedTasks: selectedTasks),
    );
  }

  FutureOr<void> _addSelectedTask(
      AddSelectedTask event, Emitter<TasksState> emit) {
    var loadedState = (state as TasksLoaded);
    var selectedTasks = List<Task>.from(loadedState.selectedTasks);
    var task = event.task;

    selectedTasks.add(task);

    emit(
      loadedState.copyWith(selectedTasks: selectedTasks),
    );
  }

  FutureOr<void> _sendTask(
      SendTaskEvent event, Emitter<TasksState> emit) async {
    if (state is TasksLoaded) {
      var loadedState = (state as TasksLoaded);

      emit(TasksSending());

      var taskorFailure =
          await sendTasksUseCase.execute(SendTasksParams(tasks: [event.task]));
      taskorFailure.fold(
        (failure) {
          homeBloc?.add(
            ShowMessageEvent(
                message:
                    "There was a failure sending the tasks: ${failure.message}",
                type: AlertType.error),
          );
          emit(loadedState);
        },
        (r) {
          homeBloc?.add(
            ShowMessageEvent(
                message:
                    "A confirmation email was sent for the suppliers of the selected tasks.",
                type: AlertType.success),
          );
          add(GetTasksEvent(jobId: loadedState.tasks.first.job));
        },
      );
    }
  }

  FutureOr<void> _updateTasks(
      UpdateTasksEvent event, Emitter<TasksState> emit) async {
    var tasksOrFailure =
        await updateTasksUseCase.execute(UpdateTasksParams(tasks: event.tasks));
    tasksOrFailure.fold(
      (failure) {
        homeBloc?.add(
          ShowMessageEvent(
              message:
                  "There was a failure updating the tasks: ${failure.message}",
              type: AlertType.error),
        );
      },
      (r) {
        homeBloc?.add(
          ShowMessageEvent(
              message: "The tasks were updated successfully",
              type: AlertType.success),
        );
      },
    );
  }

  void _updateTaskData(event, Emitter<TasksState> emit) {
    if (state is! TasksLoaded) return;

    var loadedState = (state as TasksLoaded);
    List<Task> updatedTasks = List.of(loadedState.updatedTasksData);
    Task task = event.task;

    bool exists = updatedTasks.indexWhere((i) => i.id == task.id) != -1;
    if (exists) {
      updatedTasks.removeWhere((i) => i.id == task.id);
    }
    updatedTasks.add(task);

    emit(loadedState.copyWith(
        updatedTasksData: updatedTasks, taskDataModified: true));
  }

  FutureOr<void> _saveUpdatedTasks(
      SaveUpdatedTasks event, Emitter<TasksState> emit) async {
    if (state is TasksLoaded) {
      var loadedState = (state as TasksLoaded);
      var updatedTasks = List<Task>.from(loadedState.updatedTasksData);

      List<String> errorMessages = [];

      for (var task in updatedTasks) {
        var updatedTask =
            await updateTaskUseCase.execute(UpdateTaskParams(task: task));
        updatedTask.fold(
          (failure) {
            errorMessages
                .add("Task ${task.id} couldn't be updated: ${failure.message}");
          },
          (success) {},
        );
      }

      if (errorMessages.isNotEmpty) {
        homeBloc?.add(
          ShowMessageEvent(
            message: errorMessages.join('\n'),
            type: AlertType.error,
          ),
        );
      } else {
        homeBloc?.add(
          ShowMessageEvent(
            message: "All tasks updated successfully!",
            type: AlertType.success,
          ),
        );
        emit(loadedState.copyWith(taskDataModified: false));
        add(GetTasksEvent(jobId: updatedTasks.first.job));
      }
    }
  }
}
