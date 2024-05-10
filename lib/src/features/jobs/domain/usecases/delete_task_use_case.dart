import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

class DeleteTaskUseCase implements UseCase<void, DeleteTaskParams> {
  final TasksRepository repository;

  DeleteTaskUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(params) {
    return repository.delete(params.id);
  }
}

class DeleteTaskParams {
  final int id;

  DeleteTaskParams({required this.id});
}
