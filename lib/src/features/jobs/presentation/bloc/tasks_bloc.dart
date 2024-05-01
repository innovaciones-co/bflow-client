// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_tasks_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/exceptions/failure.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final JobBloc jobBloc;
  final GetTasksUseCase getTasksUseCase;

  TasksBloc(
    this.jobBloc,
    this.getTasksUseCase,
  ) : super(TasksInitial()) {
    on<TasksEvent>((event, emit) {});
    on<GetTasksEvent>(_getTasks);

    if (jobBloc.state is JobLoaded) {
      add(GetTasksEvent(jobId: (jobBloc.state as JobLoaded).job.id));
    }
  }

  _getTasks(GetTasksEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());

    GetTasksParams params = GetTasksParams(jobId: event.jobId);
    var tasks = await getTasksUseCase.execute(params);
    tasks.fold(
      (l) => emit(TaskError(failure: l)),
      (r) => emit(TasksLoaded(tasks: r)),
    );
  }
}
