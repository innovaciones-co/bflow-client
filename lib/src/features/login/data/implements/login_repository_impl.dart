import 'dart:convert';

import 'package:bflow_client/src/core/exceptions/bad_response_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/login/data/models/jwt_payload_model.dart';
import 'package:bflow_client/src/features/login/data/sources/login_local_data_source.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:bflow_client/src/features/users/data/sources/users_remote_data_source.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/repositories.dart';
import '../sources/login_remote_data_source.dart';

class LoginRepositoryImp implements LoginRepository {
  final UsersRemoteDataSource usersRemoteDataSource;
  final LoginRemoteDataSource remoteDataSource;
  final LoginLocalDataSource localDataSource;

  LoginRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.usersRemoteDataSource,
  });

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
      String? token = await localDataSource.getToken();
      if (token == null) {
        return const Right(false);
      }

      return Right(!_isTokenExpired(token));
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
  Future<Either<Failure, User>> getLoggedUser() async {
    try {
      String? token = await localDataSource.getToken();
      if (token == null) {
        return Left(ClientFailure(message: "User not loged"));
      }
      JwtPayloadModel jwtPayload = _getJwtPayload(token);
      String username = jwtPayload.sub;

      return Right(await usersRemoteDataSource.fetchUserByUsername(username));
    } on Exception {
      return Left(
        ClientFailure(message: "It's not possible get the logged user"),
      );
    }
  }

  bool _isTokenExpired(String token) {
    try {
      JwtPayloadModel payload = _getJwtPayload(token);

      final currentTime = DateTime.now();

      return payload.exp.isBefore(currentTime);
    } catch (e) {
      return true;
    }
  }

  JwtPayloadModel _getJwtPayload(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token');
    }

    final payloadStr =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));

    return JwtPayloadModel.fromJson(payloadStr);
  }
}
