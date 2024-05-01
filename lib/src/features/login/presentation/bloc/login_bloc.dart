import 'package:bflow_client/src/features/login/domain/usecases/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginFormState> {
  final LoginUseCase loginUseCase;
  LoginCubit(this.loginUseCase) : super(const LoginFormState());

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
    final params =
        LoginParams(username: state.username, password: state.password);
    final response = await loginUseCase.execute(params);
    response.fold(
      (l) => emit(
        state.copyWith(status: FormStatus.failed, errorMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(status: FormStatus.success),
      ),
    );
  }
}
