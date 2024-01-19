import 'package:equatable/equatable.dart';

import 'user_role.dart';

class User extends Equatable {
  final int? id;

  final String firstName;

  final String lastName;

  final String username;

  final String? password;

  final String email;

  final UserRole? role;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.password,
    required this.email,
    this.role,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, password, email, role];

  String get fullName => "$firstName $lastName";
}
