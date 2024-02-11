// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:bflow_client/src/features/contacts/data/models/contact_model.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/users/data/models/user_model.dart';

import 'file_model.dart';
import 'note_model.dart';

class JobModel extends Job {
  JobModel({
    required super.id,
    required super.jobNumber,
    required super.name,
    required super.plannedStartDate,
    required super.plannedEndDate,
    required super.address,
    required super.description,
    required super.user,
    required super.client,
    required super.supervisor,
    super.notes,
    super.files,
    super.stage,
    super.progress = 0,
  });

  factory JobModel.fromEntity(Job job) => JobModel(
        id: job.id,
        jobNumber: job.jobNumber,
        name: job.name,
        plannedStartDate: job.plannedStartDate,
        plannedEndDate: job.plannedEndDate,
        address: job.address,
        description: job.description,
        client: job.client,
        user: job.user,
        stage: job.stage,
        progress: job.progress,
        notes: job.notes,
        files: job.files,
        supervisor: job.supervisor,
      );

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
        client: ContactModel.fromMap(json["client"]),
        user: UsersModel.fromMap(json["user"]),
        supervisor: UsersModel.fromMap(json["supervisor"]),
        stage: TaskStage.fromString(json["stage"]),
        progress: json["progress"] / 100 ?? 0,
        notes: json["notes"] == null
            ? []
            : List<NoteModel>.from(
                json["notes"]!.map((x) => NoteModel.fromMap(x))),
        files: json["files"] == null
            ? []
            : List<FileModel>.from(
                json["files"]!.map((x) => NoteModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "jobNumber": jobNumber,
        "name": name,
        "buildingType": "DOUBLE_STOREY",
        "plannedStartDate":
            "${plannedStartDate.year.toString().padLeft(4, '0')}-${plannedStartDate.month.toString().padLeft(2, '0')}-${plannedStartDate.day.toString().padLeft(2, '0')}",
        "plannedEndDate":
            "${plannedEndDate.year.toString().padLeft(4, '0')}-${plannedEndDate.month.toString().padLeft(2, '0')}-${plannedEndDate.day.toString().padLeft(2, '0')}",
        "address": address,
        "description": description,
        "client": client.id,
        "user": user.id,
        "supervisor": supervisor.id,
        "notes": notes == null ? [] : List<int>.from(notes!.map((x) => x.id)),
        "files": files == null ? [] : List<int>.from(files!.map((x) => x.id)),
      };
}
