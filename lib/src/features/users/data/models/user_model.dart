import 'dart:convert';

import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';

import '../../domain/entities/user_entity.dart';

class UsersModel extends User {
  const UsersModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.password,
    required super.email,
    required super.role,
  });

  factory UsersModel.fromJson(String str) =>
      UsersModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersModel.fromMap(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        password: json["password"],
        email: json["email"],
        role: json["role"] != null ? UserRole.fromString(json["role"]) : null,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
        "email": email,
        "role": role,
      };

  factory UsersModel.fromEntity(User user) => UsersModel(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
        username: user.username,
        password: user.password,
        email: user.email,
        role: user.role,
      );
}
