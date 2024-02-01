import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';

import 'package:dartz/dartz.dart';

import '../sources/login_remote_data_source.dart';
import '../../domain/repositories/repositories.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, Auth>> loginUser(
    String username,
    String password,
  ) async {
    try {
      return Right(await remoteDataSource.loginUser(username, password));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: "Invalid credentials"));
    }
  }
}