import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class CreateUserUseCase extends UseCase<User, CreateUserParams> {
  final UsersRepository repository;

  CreateUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> execute(CreateUserParams params) async {
    return await repository.createUser(params.user);
  }
}

class CreateUserParams {
  final User user;

  CreateUserParams({required this.user});
}
