import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTaskUseCase getTaskUseCase;
  final GetJobUseCase getJobUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final TasksBloc? tasksBloc;
  final HomeBloc? homeBloc;

  TaskCubit({
    required this.getJobUseCase,
    required this.getTaskUseCase,
    required this.deleteTaskUseCase,
    this.tasksBloc,
    this.homeBloc,
  }) : super(TaskInitial());

  loadTask(int taskId) async {
    var responseTask =
        await getTaskUseCase.execute(GetTaskParams(taskId: taskId));

    responseTask.fold(
      (failure) => emit(
        TaskError(failure: failure),
      ),
      (task) async {
        var responseJob = await getJobUseCase.execute(
          GetJobParams(id: task.job),
        );
        responseJob.fold(
          (failure) => emit(
            TaskError(failure: failure),
          ),
          (job) => emit(
            TaskLoaded(job: job, task: task),
          ),
        );
      },
    );
  }

  deleteTask(int id, int jobId) async {
    var response = await deleteTaskUseCase.execute(DeleteTaskParams(id: id));

    response.fold(
      (failure) => homeBloc?.add(
        ShowMessageEvent(
            message: "Task couldn't be deleted: ${failure.message}",
            type: AlertType.error),
      ),
      (_) {
        tasksBloc?.add(GetTasksEvent(jobId: jobId));
        homeBloc?.add(
          ShowMessageEvent(
              message: "Task has been deleted!", type: AlertType.success),
        );
      },
    );
  }
}
