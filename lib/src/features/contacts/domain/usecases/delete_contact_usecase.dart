import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';

import '../repositories/contacts_repository.dart';

class DeleteContactsUseCase implements UseCase<void, DeleteContactParams> {
  final ContactsRepository repository;

  DeleteContactsUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(DeleteContactParams params) {
    return repository.deleteContact(params.id);
  }
}

class DeleteContactParams {
  final int id;

  DeleteContactParams({required this.id});
}
