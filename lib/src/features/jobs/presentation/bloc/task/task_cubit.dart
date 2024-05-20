import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_task_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/pages/task_confirmation_page.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTaskUseCase getTaskUseCase;
  final GetJobUseCase getJobUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final TasksBloc? tasksBloc;
  final HomeBloc? homeBloc;

  TaskCubit({
    required this.getJobUseCase,
    required this.getTaskUseCase,
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
    this.tasksBloc,
    this.homeBloc,
  }) : super(TaskInitial());

  Future<void> loadTask(int taskId) async {
    await _loadTask(
      taskId,
      (task) => _handleJobLoad(task),
    );
  }

  Future<void> deleteTask(int id, int jobId) async {
    final response = await deleteTaskUseCase.execute(DeleteTaskParams(id: id));
    response.fold(
      (failure) => _showMessage(
          "Task couldn't be deleted: ${failure.message}", AlertType.error),
      (_) {
        tasksBloc?.add(GetTasksEvent(jobId: jobId));
        _showMessage("Task has been deleted!", AlertType.success);
      },
    );
  }

  Future<void> confirmTask() async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;
    emit(TaskLoading(job: currentState.job, task: currentState.task));

    final updatedTask =
        currentState.task.copyWith(status: TaskStatus.confirmed);

    final updatedOrFailure =
        await updateTaskUseCase.execute(UpdateTaskParams(task: updatedTask));
    updatedOrFailure.fold(
      (failure) => emit(TaskError(failure: failure)),
      (_) async {
        await _loadTask(currentState.task.id!,
            (task) => _handleJobLoad(task, TaskActionStatus.taskConfirmed));
      },
    );
  }

  Future<void> rejectTask() async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;
    emit(TaskLoading(job: currentState.job, task: currentState.task));

    final updatedTask = currentState.task.copyWith(status: TaskStatus.declined);

    final updatedOrFailure =
        await updateTaskUseCase.execute(UpdateTaskParams(task: updatedTask));
    updatedOrFailure.fold(
      (failure) => emit(TaskError(failure: failure)),
      (_) async {
        await _loadTask(currentState.task.id!,
            (task) => _handleJobLoad(task, TaskActionStatus.taskRejected));
      },
    );
  }

  Future<void> rescheduleTask(DateTime proposedDate) async {
    if (state is! TaskLoaded) return;

    final currentState = state as TaskLoaded;
    emit(TaskLoading(job: currentState.job, task: currentState.task));

    final updatedTask = currentState.task.copyWith(
      status: TaskStatus.reschedule,
      comments:
          "Supplier asked to reschedule on ${proposedDate.toIso8601String()}",
    );

    final updatedOrFailure =
        await updateTaskUseCase.execute(UpdateTaskParams(task: updatedTask));
    updatedOrFailure.fold(
      (failure) => emit(TaskError(failure: failure)),
      (_) async {
        await _loadTask(currentState.task.id!,
            (task) => _handleJobLoad(task, TaskActionStatus.taskRescheduled));
      },
    );
  }

  Future<void> _loadTask(int taskId, void Function(t.Task) onLoaded) async {
    final responseTask =
        await getTaskUseCase.execute(GetTaskParams(taskId: taskId));
    responseTask.fold(
      (failure) => emit(TaskError(failure: failure)),
      (task) async => onLoaded(task),
    );
  }

  Future<void> _handleJobLoad(t.Task task,
      [TaskActionStatus? actionStatus]) async {
    final responseJob = await getJobUseCase.execute(GetJobParams(id: task.job));
    responseJob.fold(
      (failure) => emit(TaskError(failure: failure)),
      (job) {
        if (actionStatus != null) {
          emit(TaskUpdated(job: job, task: task, actionStatus: actionStatus));
        } else {
          emit(TaskLoaded(job: job, task: task));
        }
      },
    );
  }

  void _showMessage(String message, AlertType type) {
    homeBloc?.add(ShowMessageEvent(message: message, type: type));
  }
}
