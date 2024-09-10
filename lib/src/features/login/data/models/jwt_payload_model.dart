import 'dart:convert';

import 'package:bflow_client/src/core/data/models/json_serializable.dart';

class JwtPayloadModel with JsonSerializable {
  String sub;
  String iss;
  DateTime iat;
  DateTime exp;

  JwtPayloadModel({
    required this.sub,
    required this.iss,
    required this.iat,
    required this.exp,
  });

  factory JwtPayloadModel.fromJson(String str) =>
      JwtPayloadModel.fromMap(json.decode(str));

  factory JwtPayloadModel.fromMap(Map<String, dynamic> json) => JwtPayloadModel(
        sub: json["sub"],
        iss: json["iss"],
        iat: DateTime.fromMillisecondsSinceEpoch(json['iat'] * 1000),
        exp: DateTime.fromMillisecondsSinceEpoch(json['exp'] * 1000),
      );

  @override
  Map<String, dynamic> toMap() => {
        "sub": sub,
        "iss": iss,
        "iat": iat.toIso8601String(),
        "exp": exp.toIso8601String(),
      };
}
