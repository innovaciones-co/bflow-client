import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/repositories.dart';

class GetLoggedUserUseCase extends UseCase<User, NoParams> {
  final LoginRepository repository;

  GetLoggedUserUseCase({required this.repository});

  @override
  Future<Either<Failure, User>> execute(NoParams params) async {
    return repository.getLoggedUser();
  }
}
