import 'dart:convert';

import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';

class TaskModel extends Task {
  TaskModel({
    required super.id,
    required super.name,
    super.callDate,
    super.startDate,
    super.endDate,
    super.comments,
    super.progress,
    required super.status,
    required super.stage,
    super.parentTask,
    super.supplier,
    super.attachments,
    required super.job,
  });

  factory TaskModel.fromJson(String str) => TaskModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TaskModel.fromMap(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        name: json["name"],
        callDate:
            json["callDate"] == null ? null : DateTime.parse(json["callDate"]),
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        comments: json["comments"],
        progress: json["progress"],
        status: TaskStatus.fromString(json["status"]),
        stage: TaskStage.fromString(json["stage"]),
        parentTask: json["parentTask"],
        supplier: json["supplier"],
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from(json["attachments"]!.map((x) => x)),
        job: json["job"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "callDate": callDate?.toDateFormat(),
        "startDate": startDate?.toDateFormat(),
        "endDate": endDate?.toDateFormat(),
        "comments": comments,
        "progress": progress,
        "status": status.toJSON(),
        "stage": stage.toJSON(),
        "parentTask": parentTask,
        "supplier": supplier,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "job": job,
      };
}
