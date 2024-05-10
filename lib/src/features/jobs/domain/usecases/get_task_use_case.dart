import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetTaskUseCase implements UseCase<t.Task, GetTaskParams> {
  final TasksRepository repository;

  GetTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, t.Task>> execute(params) {
    return repository.getTask(params.taskId);
  }
}

class GetTaskParams {
  final int taskId;

  GetTaskParams({required this.taskId});
}
