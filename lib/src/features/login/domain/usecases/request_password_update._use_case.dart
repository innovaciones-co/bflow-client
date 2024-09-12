import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/login/data/models/update_password_request_model.dart';
import 'package:bflow_client/src/features/login/domain/repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class RequestPasswordUpdateUseCase
    implements UseCase<void, RequestPasswordUpdateParams> {
  final LoginRepository loginRepository;

  RequestPasswordUpdateUseCase({required this.loginRepository});

  @override
  Future<Either<Failure, void>> execute(RequestPasswordUpdateParams params) {
    return loginRepository.requestToken(
      UpdatePasswordRequestModel(username: params.username),
    );
  }
}

class RequestPasswordUpdateParams {
  final String username;

  RequestPasswordUpdateParams({required this.username});
}
