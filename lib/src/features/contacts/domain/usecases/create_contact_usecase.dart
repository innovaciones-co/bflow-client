import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/contacts_repository.dart';

class CreateContactUseCase implements UseCase<Contact, CreateContactParams> {
  final ContactsRepository repository;

  CreateContactUseCase({required this.repository});

  @override
  Future<Either<Failure, Contact>> execute(CreateContactParams params) {
    return repository.saveContact(params.contact);
  }
}

class CreateContactParams {
  final Contact contact;

  CreateContactParams({required this.contact});
}
