import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetTasksUseCase implements UseCase<List<t.Task>, GetTasksParams> {
  final TasksRepository repository;

  GetTasksUseCase({required this.repository});

  @override
  Future<Either<Failure, List<t.Task>>> execute(params) {
    return repository.getTasksByJob(params.jobId);
  }
}

class GetTasksParams {
  final int jobId;

  GetTasksParams({required this.jobId});
}
