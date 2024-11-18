import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/login/domain/usecases/get_logged_user_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/is_logged_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/login_use_case.dart';
import 'package:bflow_client/src/features/login/domain/usecases/logout_use_case.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  final LoginUseCase loginUseCase;
  final IsLoggedUseCase isLoggedUseCase;
  final GetLoggedUserUseCase getLoggedUserUseCase;
  final LogoutUseCase logoutUseCase;

  LoginCubit({
    required this.loginUseCase,
    required this.isLoggedUseCase,
    required this.getLoggedUserUseCase,
    required this.logoutUseCase,
  }) : super(const LoginFormState());

  void initForm({String username = '', String password = ''}) {
    emit(state.copyWith(username: username, password: password));
  }

  void updateUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateAutovalidateMode(AutovalidateMode? autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }

  void updateStatus(FormStatus? status) {
    emit(state.copyWith(status: status));
  }

  void reset() {
    emit(const LoginFormState());
  }

  void login() async {
    emit(state.copyWith(isLoading: true));

    final params =
        LoginParams(username: state.username, password: state.password);
    final response = await loginUseCase.execute(params);

    response.fold(
      (l) => emit(
        state.copyWith(status: FormStatus.failed, errorMessage: l.message),
      ),
      (r) {
        emit(state.copyWith(status: FormStatus.success));
        reset();
      },
    );
  }

  Future<bool> isLogged() async {
    final response = await isLoggedUseCase.execute(NoParams());
    return response.fold((failure) => false, (isLogged) => isLogged);
  }

  Future<User?> getLoggedUser() async {
    final response = await getLoggedUserUseCase.execute(NoParams());
    return response.fold((failure) => null, (user) => user);
  }

  Future<bool> logout() async {
    final response = await logoutUseCase.execute(NoParams());
    return response.fold((failure) => false, (_) => true);
  }
}
