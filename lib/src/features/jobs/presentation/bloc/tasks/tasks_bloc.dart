// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bflow_client/src/core/api/api.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final JobBloc jobBloc;
  final GetTasksUseCase getTasksUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final HomeBloc? homeBloc;
  final SocketService socketService;
  List<Task> tasks = [];

  TasksBloc({
    required this.jobBloc,
    required this.getTasksUseCase,
    required this.deleteTaskUseCase,
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

    on<DeleteTasksEvent>(
      (event, emit) async {
        if (state is TasksLoaded) {
          var loadedState = (state as TasksLoaded);
          var selectedTasks = List<Task>.from(loadedState.selectedTasks);

          for (var e in selectedTasks) {
            var task =
                await deleteTaskUseCase.execute(DeleteTaskParams(id: e.id!));
            task.fold(
              (failure) => homeBloc?.add(
                ShowMessageEvent(
                    message:
                        "Task ${e.id} couldn't be deleted: ${failure.message}",
                    type: AlertType.error),
              ),
              (r) {
                add(GetTasksEvent(jobId: e.job));
              },
            );
          }
        }
      },
    );
    on<ToggleSelectedTask>(_toggleSelectdTask);
    on<AddSelectedTask>(_addSelectdTask);
    on<RemoveSelectedTask>(_removeSelectedTask);
    on<TasksEvent>((event, emit) {});
    on<LoadingTasksEvent>(_loadingTasks);
    on<GetTasksEvent>(_getTasks);

    if (jobBloc.state is JobLoaded) {
      add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
    }
  }

  FutureOr<void> _toggleSelectdTask(event, emit) {
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

    GetTasksParams params = GetTasksParams(jobId: event.jobId);
    var tasks = await getTasksUseCase.execute(params);
    tasks.fold(
      (l) => emit(TasksError(failure: l)),
      (t) {
        //tasks = t;
        emit(TasksLoaded(tasks: t));
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

    selectedTasks.remove(task);

    emit(
      loadedState.copyWith(selectedTasks: selectedTasks),
    );
  }

  FutureOr<void> _addSelectdTask(
      AddSelectedTask event, Emitter<TasksState> emit) {
    var loadedState = (state as TasksLoaded);
    var selectedTasks = List<Task>.from(loadedState.selectedTasks);
    var task = event.task;

    selectedTasks.add(task);

    emit(
      loadedState.copyWith(selectedTasks: selectedTasks),
    );
  }
}
