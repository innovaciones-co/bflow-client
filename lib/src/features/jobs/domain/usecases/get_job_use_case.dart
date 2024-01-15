import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_reposiroty.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';

class GetJobUseCase implements UseCase<Job, GetJobParams> {
  final JobsRepository repository;

  GetJobUseCase({required this.repository});

  @override
  Future<Either<Failure, Job>> execute(params) {
    return repository.getJob(params.id);
  }
}

class GetJobParams {
  final int id;

  GetJobParams({required this.id});
}
