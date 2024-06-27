import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_entity.dart';

class GetAdministratorsUseCase implements UseCase {
  final UsersRepository repository;

  GetAdministratorsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<User>>> execute(params) {
    return repository.getAdministrators();
  }
}
