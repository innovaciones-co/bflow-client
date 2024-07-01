import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/data/sources/tasks_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart'
    as t;
import 'package:bflow_client/src/features/jobs/domain/repositories/task_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/bad_request_exception.dart';
import '../../../../core/exceptions/remote_data_source_exception.dart';

class TasksRepositoryImp implements TasksRepository {
  final TasksRemoteDataSource remoteDataSource;

  TasksRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, t.Task>> createTask(t.Task task) async {
    try {
      return Right(await remoteDataSource.createTask(task));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(await remoteDataSource.deleteTask(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(
        ClientFailure(
          message: e.toString(),
          errorResponse: e.errorResponse,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, t.Task>> getTask(int id) async {
    try {
      return Right(await remoteDataSource.fetchTask(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<t.Task>>> getTasks() async {
    try {
      return Right(await remoteDataSource.fetchTasks());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<t.Task>>> getTasksByJob(int jobId) async {
    try {
      return Right(await remoteDataSource.fetchTasks(jobId: jobId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, t.Task>> updateTask(t.Task task) async {
    try {
      return Right(await remoteDataSource.updateTask(task));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTasks(List<t.Task> tasks) async {
    try {
      await remoteDataSource.updateTasks(tasks);
      return const Right(null);
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendTasks(List<t.Task> tasks) async {
    try {
      await remoteDataSource.sendTasks(tasks);
      return const Right(null);
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }
}
