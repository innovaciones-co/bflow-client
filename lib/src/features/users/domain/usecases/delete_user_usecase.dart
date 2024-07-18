import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/users_repository.dart';

class DeleteUserUseCase implements UseCase<void, DeleteUserParams> {
  final UsersRepository repository;

  DeleteUserUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(DeleteUserParams params) {
    return repository.deleteUser(params.id);
  }
}

class DeleteUserParams {
  final int id;

  DeleteUserParams({required this.id});
}
