import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_task_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTaskUseCase getTaskUseCase;
  final GetJobUseCase getJobUseCase;
  TaskCubit({required this.getJobUseCase, required this.getTaskUseCase})
      : super(TaskInitial());

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
}
