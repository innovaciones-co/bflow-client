// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tasks_filter_event.dart';
part 'tasks_filter_state.dart';

class TasksFilterBloc extends Bloc<TasksFilterEvent, TasksFilterState> {
  final TasksBloc _tasksBloc;

  TasksFilterBloc(
    this._tasksBloc,
  ) : super(TasksFilterLoading()) {
    on<UpdateTasks>(_onUpdateTasks);
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTabIndex>(_onUpdateTabIndex);

    _tasksBloc.stream.listen((state) {
      if (state is TasksLoaded) {
        add(UpdateTasks());
      }
    });
  }

  FutureOr<void> _onUpdateTasks(
      UpdateTasks event, Emitter<TasksFilterState> emit) {
    //emit(TasksFilterLoading());
    var taskBlocState = _tasksBloc.state;
    if (taskBlocState is TasksLoaded) {
      List<Task> filteredTasks = taskBlocState.tasks
          .where((task) => event.statusFilter.contains(task.status))
          .toList();

      if (state is TasksFilterLoaded) {
        emit((state as TasksFilterLoaded)
            .copyWith(tasks: filteredTasks, statusFilter: event.statusFilter));
      } else {
        emit(TasksFilterLoaded(
            tasks: filteredTasks, status: event.statusFilter));
      }
    }
  }

  FutureOr<void> _onUpdateFilter(
      UpdateFilter event, Emitter<TasksFilterState> emit) {
    final state = this.state;
    if (state is TasksFilterLoaded) {
      add(UpdateTasks(statusFilter: state.statusFilter));
    }
  }

  FutureOr<void> _onUpdateTabIndex(
      UpdateTabIndex event, Emitter<TasksFilterState> emit) {
    final state = this.state;

    if (state is TasksFilterLoaded) {
      emit(state.copyWith(tabIndex: event.tabIndex));
    }
  }
}
