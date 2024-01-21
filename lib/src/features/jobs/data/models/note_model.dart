import 'dart:convert';

class NoteModel {
  final int? id;
  final String? body;
  final int? job;

  NoteModel({
    this.id,
    this.body,
    this.job,
  });

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
