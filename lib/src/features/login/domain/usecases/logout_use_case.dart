import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  final LoginRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(NoParams params) async {
    return repository.logout();
  }
}
