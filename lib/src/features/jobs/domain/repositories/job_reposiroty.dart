import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:dartz/dartz.dart';

abstract class JobsRepository {
  Future<Either<Failure, Job>> getJob(int id);

  Future<Either<Failure, List<Job>>> getJobs();

  Future<Either<Failure, List<Job>>> getJobsByOwner();

  Future<Either<Failure, Job>> createJob(Job job);

  Future<Either<Failure, Job>> update(Job job);

  Future<Either<Failure, void>> delete(int id);
}
