import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/job_reposiroty.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class CreateJobUseCase implements UseCase<Job, CreateJobParams> {
  final JobsRepository repository;

  CreateJobUseCase({required this.repository});

  @override
  Future<Either<Failure, Job>> execute(params) async {
    var job = await repository.createJob(params.job);
    return job;
  }
}

class CreateJobParams {
  final Job job;

  CreateJobParams({required this.job});
}
