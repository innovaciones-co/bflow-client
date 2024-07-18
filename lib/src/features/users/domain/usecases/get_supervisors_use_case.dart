import 'package:bflow_client/src/features/users/domain/repositories/users_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/user_entity.dart';

class GetSupervisorsUseCase implements UseCase {
  final UsersRepository repository;

  GetSupervisorsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<User>>> execute(params) {
    return repository.getSupervisors();
  }
}
