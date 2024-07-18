import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class UpdateJobUseCase implements UseCase<Job, UpdateJobParams> {
  final JobsRepository repository;

  UpdateJobUseCase({required this.repository});

  @override
  Future<Either<Failure, Job>> execute(params) async {
    var job = await repository.update(params.job);
    return job;
  }
}

class UpdateJobParams {
  final Job job;

  UpdateJobParams({required this.job});
}
