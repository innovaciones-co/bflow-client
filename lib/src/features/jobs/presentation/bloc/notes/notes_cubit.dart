import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final int jobId;
  final CreateNoteUsecase createNoteUsecase;
  final JobBloc jobBloc;

  NotesCubit({
    required this.createNoteUsecase,
    required this.jobId,
    required this.jobBloc,
  }) : super(NotesInitial());

  addNote() async {
    var note = state.note;
    if (note == null) {
      return;
    }

    emit(NotesLoading());

    var response =
        await createNoteUsecase.execute(CreateNoteParams(note: note));

    response.fold(
      (l) => emit(NotesError(failure: l)),
      (r) {
        emit(NotesAdded());
        jobBloc.add(GetJobEvent(id: jobId));
      },
    );
  }

  updateNote(String? string) {
    if (string != null) {
      var note = Note(body: string, job: jobId);
      emit(NotesChanged(note: note));
    }
  }
}
