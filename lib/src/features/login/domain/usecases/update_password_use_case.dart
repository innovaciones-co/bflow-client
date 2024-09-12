import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/login/data/models/password_change_model.dart';
import 'package:bflow_client/src/features/login/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class UpdatePasswordUseCase implements UseCase<void, UpdatePasswordParams> {
  final LoginRepository loginRepository;

  UpdatePasswordUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, void>> execute(UpdatePasswordParams params) {
    return loginRepository.updatePassword(
        PasswordChangeModel(token: params.token, password: params.password));
  }
}

class UpdatePasswordParams {
  final String token;
  final String password;

  UpdatePasswordParams({required this.token, required this.password});
}
