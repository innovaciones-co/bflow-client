import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/delete_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_note_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final int jobId;
  final CreateNoteUsecase createNoteUsecase;
  final DeleteNoteUseCase deleteNoteUseCase;
  final UpdateNoteUseCase updateNoteUseCase;
  final JobBloc jobBloc;
  final HomeBloc? homeBloc;

  NotesCubit({
    required this.createNoteUsecase,
    required this.deleteNoteUseCase,
    required this.updateNoteUseCase,
    required this.jobId,
    required this.jobBloc,
    this.homeBloc,
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

  updateNoteBody(String? string) {
    if (string != null) {
      var note = Note(body: string, job: jobId);

      if (state is NotesEditing) {
        emit(NotesEditing(note: note));
      } else {
        emit(NotesChanged(note: note));
      }
    }
  }

  editNote(Note note) {
    emit(NotesEditing(note: note));
  }

  cancelEditNote() {
    emit(NotesInitial());
  }

  updateNote(Note note) async {
    Note noteUpdated = Note(
      id: note.id,
      body: state.note!.body,
      job: note.job,
    );

    final failureOrNote = await updateNoteUseCase.execute(
      UpdateNoteParams(note: noteUpdated),
    );

    failureOrNote.fold(
      (failure) {
        emit(NotesError(failure: failure));
      },
      (note) {
        emit(NotesLoading());
        jobBloc.add(GetJobEvent(id: jobId));
        homeBloc?.add(
          ShowMessageEvent(
            message: "Note has been updated!",
            type: AlertType.success,
          ),
        );
      },
    );
  }

  deleteNote(int id) async {
    var response = await deleteNoteUseCase.execute(DeleteNoteParams(id: id));

    response.fold(
      (failure) => homeBloc?.add(
        ShowMessageEvent(
          message: "Note couldn't be deleted: ${failure.message}",
          type: AlertType.error,
        ),
      ),
      (_) {
        emit(NotesLoading());
        jobBloc.add(GetJobEvent(id: jobId));
        homeBloc?.add(
          ShowMessageEvent(
            message: "Note has been deleted!",
            type: AlertType.success,
          ),
        );
      },
    );
  }
}
