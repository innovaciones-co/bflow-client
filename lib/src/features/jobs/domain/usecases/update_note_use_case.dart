import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecases.dart';

class UpdateNoteUseCase implements UseCase<Note, UpdateNoteParams> {
  final NotesRepository repository;

  UpdateNoteUseCase({required this.repository});

  @override
  Future<Either<Failure, Note>> execute(params) async {
    var note = await repository.update(params.note);
    return note;
  }
}

class UpdateNoteParams {
  final Note note;

  UpdateNoteParams({required this.note});
}
