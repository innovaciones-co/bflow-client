import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:dartz/dartz.dart';

abstract class ContactsRepository {
  Future<Either<Failure, Contact>> getContact(int contactId);
  Future<Either<Failure, Contact>> saveContact(Contact contact);
  Future<Either<Failure, Contact>> updateContact(Contact contact);
  Future<Either<Failure, void>> deleteContact(int contactId);
  Future<Either<Failure, List<Contact>>> getContacts(ContactType? contactType);
}
