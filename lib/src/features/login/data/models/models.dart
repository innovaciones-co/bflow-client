import 'dart:convert';

import 'package:bflow_client/src/features/login/domain/entities/auth_entity.dart';

class AuthModel extends Auth {
  AuthModel({required super.token});

  factory AuthModel.fromJson(String str) => AuthModel.fromMap(json.decode(str));

  factory AuthModel.fromMap(Map<String, dynamic> json) =>
      AuthModel(token: json['accessToken']);
}
