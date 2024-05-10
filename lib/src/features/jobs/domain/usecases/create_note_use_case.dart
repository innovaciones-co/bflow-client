import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

class CreateNoteUsecase extends UseCase<Note, CreateNoteParams> {
  final NotesRepository notesRepository;

  CreateNoteUsecase({required this.notesRepository});

  @override
  Future<Either<Failure, Note>> execute(CreateNoteParams params) {
    return notesRepository.createNote(params.note);
  }
}

class CreateNoteParams {
  final Note note;

  CreateNoteParams({required this.note});
}
