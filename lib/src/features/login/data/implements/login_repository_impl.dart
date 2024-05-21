import 'package:bflow_client/src/core/exceptions/bad_response_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/login/data/sources/login_local_data_source.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/repositories.dart';
import '../sources/login_remote_data_source.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImp(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure, Auth>> loginUser(
    String username,
    String password,
  ) async {
    try {
      Auth auth = await remoteDataSource.loginUser(username, password);
      localDataSource.saveToken(auth.token);
      return Right(auth);
    } on BadResponseException {
      return Left(ServerFailure(message: "Invalid credentials"));
    } on RemoteDataSourceException {
      return Left(ServerFailure(message: "Invalid credentials"));
    }
  }

  @override
  Future<Either<Failure, bool>> isLogged() async {
    try {
      return Right(await localDataSource.isLogged());
    } on Exception {
      return Left(ClientFailure(
          message: "It's not possible validate if user is logged"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.removeToken();
      return const Right(null);
    } on Exception {
      return Left(
        ClientFailure(message: "It' wasn't possible to  logout"),
      );
    }
  }

  @override
  Future<Either<Failure, User>> getLoggedUser() {
    // TODO: implement getLoggedUser
    throw UnimplementedError();
  }
}
