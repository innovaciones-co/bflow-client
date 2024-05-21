import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Auth>> loginUser(String username, String password);
  Future<Either<Failure, User>> getLoggedUser();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isLogged();
}
