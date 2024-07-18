// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'write_user_cubit.dart';

sealed class WriteUserState extends Equatable {
  final AutovalidateMode autovalidateMode;
  final List<UserRole> roles = UserRole.values;
  final Failure? failure;
  final FormStatus formStatus;
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? password;
  final UserRole? role;

  const WriteUserState({
    this.autovalidateMode = AutovalidateMode.disabled,
    this.failure,
    this.formStatus = FormStatus.initialized,
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.role,
  });

  @override
  List<Object?> get props => [
        autovalidateMode,
        failure,
        formStatus,
        roles,
        id,
        firstName,
        lastName,
        username,
        email,
        password,
        role,
      ];

  WriteUserState copyWith({
    AutovalidateMode? autovalidateMode,
    Failure? failure,
    FormStatus? formStatus,
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    UserRole? role,
  });
}

class WriteUserInitial extends WriteUserState {
  const WriteUserInitial({
    super.autovalidateMode = AutovalidateMode.disabled,
    super.failure,
    super.formStatus = FormStatus.initialized,
    super.id,
    super.firstName,
    super.lastName,
    super.username,
    super.email,
    super.password,
    super.role,
  });

  @override
  List<Object?> get props => [
        autovalidateMode,
        id,
        roles,
        failure,
        formStatus,
        firstName,
        lastName,
        username,
        email,
        password,
        role,
      ];

  @override
  WriteUserState copyWith({
    AutovalidateMode? autovalidateMode,
    Failure? failure,
    FormStatus? formStatus,
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? password,
    UserRole? role,
  }) {
    return WriteUserInitial(
      autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      failure: failure ?? this.failure,
      formStatus: formStatus ?? this.formStatus,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }
}
