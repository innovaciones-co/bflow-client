import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

class DeleteJobUseCase implements UseCase<void, DeleteJobParams> {
  final JobsRepository repository;

  DeleteJobUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(params) {
    return repository.delete(params.id);
  }
}

class DeleteJobParams {
  final int id;

  DeleteJobParams({required this.id});
}
