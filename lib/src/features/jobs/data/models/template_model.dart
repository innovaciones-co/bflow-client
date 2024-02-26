import 'dart:convert';

import 'package:bflow_client/src/features/jobs/domain/entities/template_entity.dart';

class TemplateModel extends TemplateEntity {
  final String? template;

  TemplateModel({
    required super.id,
    required super.name,
    this.template,
  });

  factory TemplateModel.fromJson(String str) =>
      TemplateModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TemplateModel.fromMap(Map<String, dynamic> json) => TemplateModel(
        id: json["id"],
        name: json["name"],
        template: json["template"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "template": template,
      };
}
