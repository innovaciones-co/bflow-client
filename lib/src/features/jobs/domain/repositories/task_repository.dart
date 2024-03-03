import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

abstract class TasksRepository {
  Future<Either<Failure, t.Task>> getTask(int id);

  Future<Either<Failure, List<t.Task>>> getTasks();

  Future<Either<Failure, List<t.Task>>> getTasksByJob(int jobId);

  Future<Either<Failure, t.Task>> createTask(t.Task task);

  Future<Either<Failure, t.Task>> updateTask(t.Task task);

  Future<Either<Failure, void>> delete(int id);
}
