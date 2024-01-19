import 'package:bflow_client/src/core/exceptions/failure.dart';

import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/remote_data_source_exception.dart';
import '../sources/users_remote_data_source.dart';
import '../../domain/repositories/users_repository.dart';

class UsersRepositoryImp implements UsersRepository {
  final UsersRemoteDataSource remoteDataSource;

  UsersRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> createUser(User user) {
    // TODO: implement createUser
    throw UnimplementedError();
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
  Future<Either<Failure, User>> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
