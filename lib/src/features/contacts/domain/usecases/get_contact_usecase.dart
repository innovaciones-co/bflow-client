import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/contacts_repository.dart';

class GetContactUseCase implements UseCase<Contact, GetContactParams> {
  final ContactsRepository repository;

  GetContactUseCase({required this.repository});

  @override
  Future<Either<Failure, Contact>> execute(GetContactParams params) {
    return repository.getContact(params.id);
  }
}

class GetContactParams {
  final int id;

  GetContactParams({required this.id});
}
