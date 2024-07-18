import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/repositories/note_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';

class DeleteNoteUseCase implements UseCase<void, DeleteNoteParams> {
  final NotesRepository repository;

  DeleteNoteUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> execute(params) {
    return repository.delete(params.id);
  }
}

class DeleteNoteParams {
  final int id;

  DeleteNoteParams({required this.id});
}
