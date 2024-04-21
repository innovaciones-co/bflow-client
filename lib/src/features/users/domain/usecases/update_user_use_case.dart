import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUseCase extends UseCase<User, UpdateUserParams> {
  final UsersRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> execute(UpdateUserParams params) async {
    return await repository.updateUser(params.user);
  }
}

class UpdateUserParams {
  final User user;

  UpdateUserParams({required this.user});
}
