import 'dart:convert';

import 'package:bflow_client/src/features/jobs/domain/entities/note_entity.dart';

class NoteModel extends Note {
  const NoteModel({
    super.id,
    required super.body,
    super.job,
  });

  factory NoteModel.fromEntity(Note note) => NoteModel(
        body: note.body,
        job: note.job,
        id: note.id,
      );

  factory NoteModel.fromJson(String str) => NoteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        body: json["body"],
        job: json["job"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "job": job,
      };
}
