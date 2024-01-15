import 'dart:convert';

import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';

import 'file_model.dart';
import 'note_model.dart';

class JobModel extends Job {
  @override
  final int id;
  @override
  final String jobNumber;
  @override
  final String name;
  @override
  final DateTime plannedStartDate;
  @override
  final DateTime plannedEndDate;
  @override
  final String address;
  @override
  final String description;
  final String? buildingType;
  final int? client;
  final int? user;
  final List<NoteModel>? notes;
  final List<FileModel>? files;

  JobModel({
    required this.id,
    required this.jobNumber,
    required this.name,
    required this.plannedStartDate,
    required this.plannedEndDate,
    required this.address,
    required this.description,
    this.buildingType,
    this.client,
    this.user,
    this.notes,
    this.files,
  }) : super(
            id: id,
            jobNumber: jobNumber,
            name: name,
            plannedStartDate: plannedStartDate,
            plannedEndDate: plannedEndDate,
            address: address,
            description: description,
            owner: '');

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
        user: json["user"],
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
