import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';
import '../entities/contact_entity.dart';
import '../entities/contact_type.dart';
import '../repositories/contacts_repository.dart';

class GetSuppliersUseCase implements UseCase<List<Contact>, GetContactsParams> {
  final ContactsRepository repository;

  GetSuppliersUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Contact>>> execute(GetContactsParams params) {
    return repository.getContacts(params.contactType);
  }
}

class GetContactsParams {
  final ContactType? contactType;

  GetContactsParams({this.contactType});
}
