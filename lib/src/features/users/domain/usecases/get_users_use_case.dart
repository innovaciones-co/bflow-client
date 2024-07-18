import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../entities/user_entity.dart';
import '../repositories/users_repository.dart';

class GetUsersUseCase implements UseCase {
  final UsersRepository repository;

  GetUsersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<User>>> execute(params) {
    return repository.getUsers();
  }
}
