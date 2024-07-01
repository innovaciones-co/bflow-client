import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UsersRepository {
  Future<Either<Failure, User>> getUser(int id);

  Future<Either<Failure, List<User>>> getUsers();

  Future<Either<Failure, List<User>>> getSupervisors();

  Future<Either<Failure, List<User>>> getAdministrators();

  Future<Either<Failure, User>> createUser(User user);

  Future<Either<Failure, User>> updateUser(User user);

  Future<Either<Failure, void>> deleteUser(int id);
}
