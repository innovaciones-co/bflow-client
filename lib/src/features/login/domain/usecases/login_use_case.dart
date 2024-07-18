import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class LoginUseCase extends UseCase<Auth, LoginParams> {
  final LoginRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, Auth>> execute(LoginParams params) async {
    return repository.loginUser(params.username, params.password);
  }
}

class LoginParams {
  final String username;
  final String password;

  LoginParams({required this.username, required this.password});
}
