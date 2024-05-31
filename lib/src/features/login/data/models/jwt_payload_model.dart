import 'dart:convert';

class JwtPayloadModel {
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

  String toJson() => json.encode(toMap());

  factory JwtPayloadModel.fromMap(Map<String, dynamic> json) => JwtPayloadModel(
        sub: json["sub"],
        iss: json["iss"],
        iat: DateTime.fromMillisecondsSinceEpoch(json['iat'] * 1000),
        exp: DateTime.fromMillisecondsSinceEpoch(json['exp'] * 1000),
      );

  Map<String, dynamic> toMap() => {
        "sub": sub,
        "iss": iss,
        "iat": iat.toIso8601String(),
        "exp": exp.toIso8601String(),
      };
}
