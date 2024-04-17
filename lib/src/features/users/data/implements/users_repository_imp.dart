import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/remote_data_source_exception.dart';
import '../../domain/repositories/users_repository.dart';
import '../sources/users_remote_data_source.dart';

class UsersRepositoryImp implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> createUser(User user) async {
    try {
      return Right(await remoteDataSource.createUser(user));
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
  Future<Either<Failure, void>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> getUser(int id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<User>>> getUsers() async {
    try {
      return Right(await remoteDataSource.fetchUsers());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getSupervisors() async {
    try {
      return Right(await remoteDataSource.fetchSupervisors());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User user) async {
    try {
      final updatedUser = await remoteDataSource.updateUser(user);
      return Right(updatedUser);
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
