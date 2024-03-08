import 'package:bflow_client/src/core/exceptions/bad_request_exception.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/exceptions/remote_data_source_exception.dart';
import 'package:bflow_client/src/features/jobs/data/sources/notes_remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class NotesRepositoryImp implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;

  NotesRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, Note>> createNote(Note note) async {
    try {
      return Right(await remoteDataSource.createNote(note));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return Right(await remoteDataSource.deleteNote(id));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> update(Note note) async {
    try {
      return Right(await remoteDataSource.updateNote(note));
    } on RemoteDataSourceException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on BadRequestException catch (e) {
      return Left(ClientFailure(message: e.toString()));
    }
  }
}
