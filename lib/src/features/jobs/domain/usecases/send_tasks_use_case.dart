import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class SendTasksUseCase extends UseCase<void, SendTasksParams> {
  final TasksRepository repository;

  SendTasksUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(SendTasksParams params) {
    return repository.sendTasks(params.tasks);
  }
}

class SendTasksParams {
  final List<t.Task> tasks;

  SendTasksParams({required this.tasks});
}
