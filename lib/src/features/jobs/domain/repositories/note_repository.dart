import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NotesRepository {
  Future<Either<Failure, Note>> createNote(Note note);

  Future<Either<Failure, Note>> update(Note note);

  Future<Either<Failure, void>> delete(int id);
}
