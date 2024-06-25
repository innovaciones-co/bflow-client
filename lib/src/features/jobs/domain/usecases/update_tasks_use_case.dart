import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateTasksUseCase implements UseCase<void, UpdateTasksParams> {
  final TasksRepository repository;

  UpdateTasksUseCase({required this.repository});
  @override
  Future<Either<Failure, void>> execute(UpdateTasksParams params) async {
    return repository.updateTasks(params.tasks);
  }
}

class UpdateTasksParams {
  final List<t.Task> tasks;

  UpdateTasksParams({required this.tasks});
}
