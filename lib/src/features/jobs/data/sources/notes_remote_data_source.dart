import 'package:bflow_client/src/core/data/sources/remote_data_source.dart';
import 'package:bflow_client/src/features/jobs/data/models/note_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';

import '../../../../core/api/api.dart';

class NotesRemoteDataSource extends RemoteDataSource {
  NotesRemoteDataSource({required super.apiService});

  Future<NoteModel> createNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    int taskId = await apiService.post(
      endpoint: ApiConstants.notesEndpoint,
      data: noteModel.toMap(),
    );

    return fetchNote(taskId);
  }

  Future<NoteModel> updateNote(Note note) async {
    final noteModel = NoteModel.fromEntity(note);
    int taskId = await apiService.put(
      endpoint:
          ApiConstants.noteEndpoint.replaceAll(':id', noteModel.id.toString()),
      data: noteModel.toMap(),
    );

    return fetchNote(taskId);
  }

  Future<NoteModel> fetchNote(int noteId) async {
    Map<String, dynamic> response = await apiService.get(
        endpoint:
            ApiConstants.noteEndpoint.replaceFirst(':id', noteId.toString()));
    return NoteModel.fromMap(response);
  }

  Future<void> deleteNote(int id) async {
    await apiService.delete(
      endpoint: ApiConstants.noteEndpoint.replaceAll(':id', id.toString()),
    );
  }
}
