// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/string_utils_extension.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/contacts/domain/usecases/get_contacts_usecase.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/data/models/task_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/send_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

part 'tasks_event.dart';

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
  }) : super(const TasksState(
          allTasks: [],
        )) {
    socketService.init();
    socketService.addSubscription(
      SocketSubscription(
        topic: SocketConstants.tasksTopic,
        callback: (StompFrame frame) {
          add(OnReceivedTaskEvent(frame: frame));
        },
      ),
    );

    on<UpdateTasksEvent>(_updateTasks);
    on<DeleteTasksEvent>(_deleteTasks);
    on<ToggleSelectedTask>(_toggleSelectedTask);
    on<AddSelectedTask>(_addSelectedTask);
    on<AddUpdatedTasks>(_addUpdatedTasks);
    on<RemoveSelectedTask>(_removeSelectedTask);
    on<SendTaskEvent>(_sendTask);
    on<SendSelectedTasksEvent>(_sendTasks);
    on<TasksEvent>((event, emit) {});
    on<LoadingTasksEvent>(_loadingTasks);
    on<GetTasksEvent>(_getTasks);
    on<UpdateTaskDataEvent>(_updateTaskData);
    // on<SaveUpdatedTasks>(_saveUpdatedTasks);
    on<OnReceivedTaskEvent>(_receiveTaskEvent);
    on<SearchTasks>(_searchTasks);

    if (jobBloc.state is JobLoaded) {
      add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
    }
  }

  FutureOr<void> _sendTasks(event, emit) async {
    var selectedTasks = List<Task>.from(state.selectedTasks);

    emit(state.copyWith(isLoading: true));

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
        emit(state);
      },
      (r) {
        homeBloc?.add(
          ShowMessageEvent(
              message:
                  "A confirmation email was sent for the suppliers of the selected tasks.",
              type: AlertType.success),
        );

        add(GetTasksEvent(jobId: state.allTasks.first.job));
      },
    );
  }

  FutureOr<void> _deleteTasks(event, emit) async {
    var selectedTasks = List<Task>.from(state.selectedTasks);

    emit(state.copyWith(isDeleting: true));

    for (var e in selectedTasks) {
      var task = await deleteTaskUseCase.execute(DeleteTaskParams(id: e.id!));
      task.fold(
        (failure) {
          homeBloc?.add(
            ShowMessageEvent(
                message: "Task ${e.id} couldn't be deleted: ${failure.message}",
                type: AlertType.error),
          );
          emit(state);
        },
        (r) {
          add(GetTasksEvent(jobId: e.job));
        },
      );
    }
  }

  FutureOr<void> _toggleSelectedTask(event, emit) {
    var selectedTasks = List<Task>.from(state.selectedTasks);
    var task = event.task;

    if (selectedTasks.contains(task)) {
      selectedTasks.remove(task);
    } else {
      selectedTasks.add(task);
    }

    emit(
      state.copyWith(selectedTasks: selectedTasks),
    );
  }

  _getTasks(GetTasksEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(isLoading: true));

    GetTasksParams taskParams = GetTasksParams(jobId: event.jobId);
    var tasksOrFailure = await getTasksUseCase.execute(taskParams);
    GetContactsParams contactParams =
        GetContactsParams(contactType: ContactType.supplier);
    var suppliersOrFailure = await getContactsUseCase.execute(contactParams);

    suppliersOrFailure.fold(
      (l) => emit(state.copyWith(error: l)),
      (suppliers) {
        tasksOrFailure.fold(
          (l) => emit(state.copyWith(error: l)),
          (t) {
            t.sort((a, b) => (a.order ?? 0) - (b.order ?? 0));
            emit(
              TasksState(
                allTasks: t,
                filteredTasks: t,
                contacts: List.of(suppliers)..add(null),
                tasksUpdated: const [],
              ),
            );
          },
        );
      },
    );
  }

  FutureOr<void> _loadingTasks(
      LoadingTasksEvent event, Emitter<TasksState> emit) {
    emit(state.copyWith(isLoading: true));
  }

  FutureOr<void> _removeSelectedTask(
      RemoveSelectedTask event, Emitter<TasksState> emit) {
    var selectedTasks = List<Task>.from(state.selectedTasks);
    var task = event.task;

    emit(state.copyWith(isDeleting: true));

    selectedTasks.remove(task);

    emit(
      state.copyWith(selectedTasks: selectedTasks),
    );
  }

  FutureOr<void> _addSelectedTask(
      AddSelectedTask event, Emitter<TasksState> emit) {
    var selectedTasks = List<Task>.from(state.selectedTasks);
    var task = event.task;

    selectedTasks.add(task);

    emit(
      state.copyWith(selectedTasks: selectedTasks),
    );
  }

  FutureOr<void> _sendTask(
      SendTaskEvent event, Emitter<TasksState> emit) async {
    emit(state.copyWith(isSending: true));

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
        emit(state);
      },
      (r) {
        homeBloc?.add(
          ShowMessageEvent(
              message:
                  "A confirmation email was sent for the suppliers of the selected tasks.",
              type: AlertType.success),
        );
        add(GetTasksEvent(jobId: state.allTasks.first.job));
      },
    );
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

        add(GetTasksEvent(jobId: event.tasks.first.job));
      },
    );
  }

  void _updateTaskData(event, Emitter<TasksState> emit) {
    List<Task> updatedTasks = List.of(state.tasksUpdated);
    List<Task> tasks = List.of(state.allTasks);
    Task newTask = event.task;

    Map<int, Task> updatedTasksMap = {
      for (var item in updatedTasks) item.id!: item
    };

    // Properly update the tasks list
    for (int i = 0; i < tasks.length; i++) {
      if (updatedTasksMap.containsKey(tasks[i].id)) {
        tasks[i] = updatedTasksMap[tasks[i].id]!;
      }
    }

    // Handle the new task
    bool exists = updatedTasks.indexWhere((i) => i.id == newTask.id) != -1;
    if (exists) {
      updatedTasks.removeWhere((i) => i.id == newTask.id);
    }
    updatedTasks.add(newTask);

    emit(state.copyWith(
      tasksUpdated: updatedTasks,
      allTasks: tasks,
    ));
  }

  /* FutureOr<void> _saveUpdatedTasks(
      SaveUpdatedTasks event, Emitter<TasksState> emit) async {
    if (state is TasksLoaded) {
        var updatedTasks = List<Task>.from(state.updatedTasks);

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
        emit(state.copyWith(taskDataModified: false));
        add(GetTasksEvent(jobId: updatedTasks.first.job));
      }
    }
  } */

  FutureOr<void> _receiveTaskEvent(
      OnReceivedTaskEvent event, Emitter<TasksState> emit) {
    if (jobBloc.state is JobLoaded) {
      if (event.frame.body != null) {
        Task updatedTask = TaskModel.fromJson(event.frame.body!);
        List<Task> currentTasks = state.allTasks;
        currentTasks.removeWhere((element) => element.id == updatedTask.id);
        currentTasks.add(updatedTask);
        emit(state.copyWith(allTasks: currentTasks));
      } else {
        add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
      }
    }
  }

  FutureOr<void> _addUpdatedTasks(
      AddUpdatedTasks event, Emitter<TasksState> emit) {
    var tasks = event.updatedTasks;
    emit(state.copyWith(tasksUpdated: tasks));
  }

  _searchTasks(SearchTasks event, Emitter<TasksState> emit) {
    var value = event.value;

    final tasks = state.allTasks;

    if (value.isNotEmpty) {
      List<Task> tasksSearched =
          tasks.where((contact) => contact.name.search(value)).toList();

      emit(state.copyWith(filteredTasks: tasksSearched));
    } else {
      emit(state.copyWith(filteredTasks: tasks));
    }
  }
}
