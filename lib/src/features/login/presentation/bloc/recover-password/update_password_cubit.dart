import 'package:bflow_client/src/features/login/domain/usecases/update_password_use_case.dart';
import 'package:bflow_client/src/features/login/presentation/bloc/recover-password/update_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit Definition
class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;

  UpdatePasswordCubit({required this.updatePasswordUseCase})
      : super(const UpdatePasswordState());

  Future<void> updatePassword(String token, String newPassword) async {
    emit(state.copyWith(isLoading: true));

    final params = UpdatePasswordParams(token: token, password: newPassword);
    final result = await updatePasswordUseCase.execute(params);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          error: failure,
          message: null,
        ),
      ),
      (_) => emit(
        state.copyWith(
          isLoading: false,
          message: 'Password updated successfully.',
          error: null,
        ),
      ),
    );
  }
}
