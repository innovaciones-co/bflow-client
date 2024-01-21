// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/users/data/models/user_model.dart';

import 'file_model.dart';
import 'note_model.dart';

class JobModel extends Job {
  final String? buildingType;
  final List<NoteModel>? notes;
  final List<FileModel>? files;

  JobModel({
    required super.id,
    required super.jobNumber,
    required super.name,
    required super.plannedStartDate,
    required super.plannedEndDate,
    required super.address,
    required super.description,
    this.buildingType,
    required super.user,
    super.client,
    this.notes,
    this.files,
    super.stage,
    super.progress = 0,
  });

  factory JobModel.fromJson(String str) => JobModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory JobModel.fromMap(Map<String, dynamic> json) => JobModel(
        id: json["id"],
        jobNumber: json["jobNumber"],
        name: json["name"],
        plannedStartDate: DateTime.parse(json["plannedStartDate"]),
        plannedEndDate: DateTime.parse(json["plannedEndDate"]),
        address: json["address"],
        description: json["description"],
        buildingType: json["buildingType"],
        client: json["client"],
        user: UsersModel.fromMap(json["user"]),
        stage: TaskStage.fromString(json["stage"]),
        progress: json["progress"] / 100 ?? 0,
        notes: json["notes"] == null
            ? []
            : List<NoteModel>.from(
                json["notes"]!.map((x) => NoteModel.fromMap(x))),
        files: json["files"] == null
            ? []
            : List<FileModel>.from(
                json["files"]!.map((x) => FileModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "jobNumber": jobNumber,
        "name": name,
        "plannedStartDate":
            "${plannedStartDate.year.toString().padLeft(4, '0')}-${plannedStartDate.month.toString().padLeft(2, '0')}-${plannedStartDate.day.toString().padLeft(2, '0')}",
        "plannedEndDate":
            "${plannedEndDate.year.toString().padLeft(4, '0')}-${plannedEndDate.month.toString().padLeft(2, '0')}-${plannedEndDate.day.toString().padLeft(2, '0')}",
        "address": address,
        "description": description,
        "buildingType": buildingType,
        "client": client,
        "user": user,
        "notes": notes == null
            ? []
            : List<dynamic>.from(notes!.map((x) => x.toMap())),
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toMap())),
      };
}
