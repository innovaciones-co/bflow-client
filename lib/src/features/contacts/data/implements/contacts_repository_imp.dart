import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_type.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/contacts_repository.dart';
import '../sources/sources.dart';

class ContactsRepositoryImp implements ContactsRepository {
  final ContactsRemoteDataSource remoteDataSource;
  ContactsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> deleteContact(int contactId) async {
    try {
      return Right(await remoteDataSource.deleteContact(contactId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(
        ClientFailure(
          message: e.toString(),
          errorResponse: e.errorResponse,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Contact>> getContact(int contactId) async {
    try {
      return Right(await remoteDataSource.fetchContact(contactId));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContacts(
      ContactType? contactType) async {
    try {
      return Right(await remoteDataSource.fetchContacts());
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Contact>> saveContact(Contact contact) async {
    try {
      return Right(await remoteDataSource.createContact(contact));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(
        ClientFailure(
          message: e.toString(),
          errorResponse: e.errorResponse,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Contact>> updateContact(Contact contact) async {
    try {
      return Right(await remoteDataSource.updateContact(contact));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(
        ClientFailure(
          message: e.toString(),
          errorResponse: e.errorResponse,
        ),
      );
    }
  }
}
