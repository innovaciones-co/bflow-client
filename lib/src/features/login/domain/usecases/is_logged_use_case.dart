import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class IsLoggedUseCase extends UseCase<bool, NoParams> {
  final LoginRepository repository;

  IsLoggedUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> execute(NoParams params) async {
    return repository.isLogged();
  }
}
