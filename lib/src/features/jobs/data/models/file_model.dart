import 'dart:convert';

class FileModel {
  final int? id;
  final String? uuid;
  final String? temporaryUrl;
  final String? bucket;
  final String? name;
  final String? type;
  final String? category;
  final String? tag;
  final int? job;

  FileModel({
    this.id,
    this.uuid,
    this.temporaryUrl,
    this.bucket,
    this.name,
    this.type,
    this.category,
    this.tag,
    this.job,
  });

  factory FileModel.fromJson(String str) => FileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileModel.fromMap(Map<String, dynamic> json) => FileModel(
        id: json["id"],
        uuid: json["uuid"],
        temporaryUrl: json["temporaryUrl"],
        bucket: json["bucket"],
        name: json["name"],
        type: json["type"],
        category: json["category"],
        tag: json["tag"],
        job: json["job"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "uuid": uuid,
        "temporaryUrl": temporaryUrl,
        "bucket": bucket,
        "name": name,
        "type": type,
        "category": category,
        "tag": tag,
        "job": job,
      };
}
