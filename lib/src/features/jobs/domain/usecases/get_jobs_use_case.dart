import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../entities/job_entity.dart';
import '../repositories/job_reposiroty.dart';

class GetJobsUseCase implements UseCase<List<Job>, NoParams> {
  final JobsRepository repository;

  GetJobsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Job>>> execute(params) {
    return repository.getJobs();
  }
}
