import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:dartz/dartz.dart';

import '../repositories/contacts_repository.dart';

class GetContactsUseCase implements UseCase<List<Contact>, GetContactsParams> {
  final ContactsRepository repository;

  GetContactsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Contact>>> execute(GetContactsParams params) {
    return repository.getContacts(params.contactType);
  }
}

class GetContactsParams {
  final ContactType? contactType;

  GetContactsParams({this.contactType});
}
