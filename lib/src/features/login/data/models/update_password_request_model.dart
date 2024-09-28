import 'dart:convert';

import 'package:bflow_client/src/core/data/models/json_serializable.dart';

class UpdatePasswordRequestModel with JsonSerializable {
  final String username;

  UpdatePasswordRequestModel({required this.username});

  @override
  Map<String, dynamic> toMap() {
    return {
      'username': username,
    };
  }

  factory UpdatePasswordRequestModel.fromMap(Map<String, dynamic> map) =>
      UpdatePasswordRequestModel(
        username: map['username'],
      );

  factory UpdatePasswordRequestModel.fromJson(String str) =>
      UpdatePasswordRequestModel.fromMap(json.decode(str));
}
