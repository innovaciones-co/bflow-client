part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginFormState extends LoginState {
  final FormStatus status;
  final AutovalidateMode autovalidateMode;
  final String username;
  final String password;
  final String? errorMessage;

  const LoginFormState(
      {this.username = '',
      this.password = '',
      this.autovalidateMode = AutovalidateMode.disabled,
      this.status = FormStatus.initialized,
      this.errorMessage});

  LoginFormState copyWith(
          {String? username,
          String? password,
          AutovalidateMode? autovalidateMode,
          String? errorMessage,
          FormStatus? status}) =>
      LoginFormState(
        autovalidateMode: autovalidateMode ?? this.autovalidateMode,
        username: username ?? this.username,
        password: password ?? this.password,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [
        username,
        password,
        autovalidateMode,
        errorMessage ?? '',
        status,
      ];
}

enum FormStatus { initialized, inProgress, failed, success }
