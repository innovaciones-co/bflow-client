import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/job_repository.dart';
import '../sources/jobs_remote_data_source.dart';

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
  Future<Either<Failure, Job>> createJob(Job job) async {
    try {
      return Right(await remoteDataSource.createJob(job));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(await remoteDataSource.deleteJob(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Job>> getJob(int id) async {
    try {
      return Right(await remoteDataSource.fetchJob(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Job>>> getJobsByOwner() {
    // TODO: implement getJobsByOwner
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Job>> update(Job job) async {
    try {
      return Right(await remoteDataSource.updateJob(job));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }
}
