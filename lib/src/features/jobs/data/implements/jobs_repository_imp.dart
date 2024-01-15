import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:dartz/dartz.dart';

import '../sources/jobs_remote_data_source.dart';
import '../../domain/repositories/job_reposiroty.dart';

class JobsRepositoryImp implements JobsRepository {
  final JobsRemoteDataSource remoteDataSource;
  JobsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Job>>> getJobs() async {
    try {
      return Right(await remoteDataSource.fetchJobs());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Job>> createJob(Job job) {
    // TODO: implement createJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Job>> getJob(int id) {
    // TODO: implement getJob
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Job>>> getJobsByOwner() {
    // TODO: implement getJobsByOwner
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Job>> update(Job job) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
