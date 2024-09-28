import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/login/domain/usecases/request_password_update._use_case.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_password_update_state.dart';

class RequestPasswordUpdateCubit extends Cubit<RequestPasswordUpdateState> {
  final RequestPasswordUpdateUseCase requestPasswordUpdateUseCase;
  RequestPasswordUpdateCubit({
    required this.requestPasswordUpdateUseCase,
  }) : super(const RequestPasswordUpdateInitial());

  updateUsername(String username) {
    if (state is RequestPasswordUpdateInitial) {
      emit(
          (state as RequestPasswordUpdateInitial).copyWith(username: username));
      return;
    }

    emit(RequestPasswordUpdateInitial(username: username));
  }

  updateAutovalidateMode(AutovalidateMode autovalidateMode) {
    if (state is RequestPasswordUpdateInitial) {
      emit((state as RequestPasswordUpdateInitial)
          .copyWith(autovalidateMode: autovalidateMode));
      return;
    }

    emit(RequestPasswordUpdateInitial(autovalidateMode: autovalidateMode));
  }

  requestToken() async {
    if (state is RequestPasswordUpdateInitial) {
      var username = (state as RequestPasswordUpdateInitial).username;
      if (username.isEmpty) {
        emit(
          RequestPasswordUpdateError(
            failure: ClientFailure(message: "Username is empty"),
          ),
        );
        return;
      }

      emit(RequestPasswordUpdateLoading());

      var response = await requestPasswordUpdateUseCase
          .execute(RequestPasswordUpdateParams(username: username));

      response.fold(
        (l) => emit(RequestPasswordUpdateError(failure: l)),
        (r) => emit(const RequestPasswordUpdateDone(
            tokenRequested: true,
            message: "A token was sent to the registered email.")),
      );
    }
  }

  tokenRequested(bool tokenRequested) {
    emit(RequestPasswordUpdateDone(tokenRequested: tokenRequested));
  }
}
