import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class CreateTaskUseCase implements UseCase<t.Task, CreateTaskParams> {
  final TasksRepository repository;

  CreateTaskUseCase({required this.repository});
  @override
  Future<Either<Failure, t.Task>> execute(CreateTaskParams params) async {
    var task = await repository.createTask(params.task);
    return task;
  }
}

class CreateTaskParams {
  final t.Task task;

  CreateTaskParams({required this.task});
}
