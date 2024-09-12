import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/login/data/models/password_change_model.dart';
import 'package:bflow_client/src/features/login/data/models/update_password_request_model.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Auth>> loginUser(String username, String password);
  Future<Either<Failure, void>> requestToken(
      UpdatePasswordRequestModel request);
  Future<Either<Failure, void>> updatePassword(
      PasswordChangeModel passwordChangeModel);
  Future<Either<Failure, User>> getLoggedUser();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isLogged();
}
