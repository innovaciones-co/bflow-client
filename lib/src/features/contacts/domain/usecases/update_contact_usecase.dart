import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:dartz/dartz.dart';

import '../repositories/contacts_repository.dart';

class UpdateContactUseCase implements UseCase<Contact, UpdateContactParams> {
  final ContactsRepository repository;

  UpdateContactUseCase({required this.repository});

  @override
  Future<Either<Failure, Contact>> execute(UpdateContactParams params) {
    return repository.updateContact(params.contact);
  }
}

class UpdateContactParams {
  final Contact contact;

  UpdateContactParams({required this.contact});
}
