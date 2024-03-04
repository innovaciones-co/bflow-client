import 'dart:convert';

import 'package:bflow_client/src/features/jobs/domain/entities/file_category.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/file_tag.dart';
import 'package:flutter/material.dart';

class FileModel extends File {
  const FileModel({
    required super.id,
    required super.uuid,
    required super.temporaryUrl,
    super.bucket,
    required super.name,
    super.type,
    super.category,
    super.tag,
    super.job,
  });

  factory FileModel.fromJson(String str) => FileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileModel.fromMap(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return FileModel(
      id: json["id"],
      uuid: json["uuid"],
      temporaryUrl: json["temporaryUrl"],
      bucket: json["bucket"],
      name: json["name"],
      type: json["type"],
      category: json["category"] != null
          ? FileCategory.fromString(json["category"])
          : null,
      tag: json["tag"] != null ? FileTag.fromString(json["tag"]) : null,
      job: json["job"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "temporaryUrl": temporaryUrl,
        "bucket": bucket,
        "name": name,
        "type": type,
        "category": category?.toJSON(),
        "tag": tag?.toJSON(),
        "job": job,
      };
}
