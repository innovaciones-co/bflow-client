import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, Auth>> loginUser(String username, String password);
}
