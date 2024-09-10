import 'dart:convert';

import 'package:bflow_client/src/core/data/models/json_serializable.dart';

class PasswordChangeModel with JsonSerializable {
  final String token;
  final String password;

  PasswordChangeModel({required this.token, required this.password});

  @override
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'password': password,
    };
  }

  factory PasswordChangeModel.fromMap(Map<String, dynamic> map) =>
      PasswordChangeModel(
        token: map['token'],
        password: map['password'],
      );

  factory PasswordChangeModel.fromJson(String str) =>
      PasswordChangeModel.fromMap(json.decode(str));
}
