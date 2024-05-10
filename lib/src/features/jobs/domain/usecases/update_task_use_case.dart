import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateTaskUseCase implements UseCase<t.Task, UpdateTaskParams> {
  final TasksRepository repository;

  UpdateTaskUseCase({required this.repository});
  @override
  Future<Either<Failure, t.Task>> execute(UpdateTaskParams params) async {
    var task = await repository.updateTask(params.task);
    return task;
  }
}

class UpdateTaskParams {
  final t.Task task;

  UpdateTaskParams({required this.task});
}
