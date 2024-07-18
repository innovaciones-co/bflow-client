import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_role.dart';
import 'package:bflow_client/src/features/users/domain/usecases/create_user_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/update_user_use_case.dart';
import 'package:bflow_client/src/features/users/presentation/bloc/users_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'write_user_state.dart';

class WriteUserCubit extends Cubit<WriteUserState> {
  final CreateUserUseCase createUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final UsersBloc usersBloc;

  WriteUserCubit({
    required this.createUserUseCase,
    required this.updateUserUseCase,
    required this.usersBloc,
  }) : super(const WriteUserInitial());

  void initForm({
    final int? id,
    final UserRole? role,
    final String? password,
    final String firstName = '',
    final String lastName = '',
    final String username = '',
    final String email = '',
  }) {
    emit(state.copyWith(
      id: id,
      role: role,
      password: password,
      firstName: firstName,
      lastName: lastName,
      username: username,
      email: email,
    ));
  }

  void initFormFromUser(User? user) {
    if (user == null) {
      return;
    }
    initForm(
      id: user.id,
      role: user.role,
      password: user.password,
      firstName: user.firstName,
      lastName: user.lastName,
      username: user.username,
      email: user.email,
    );
  }

  Future<void> createUser() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    User user = User(
      role: state.role,
      password: state.password,
      firstName: state.firstName!,
      lastName: state.lastName!,
      username: state.username!,
      email: state.email!,
    );

    final failureOrUser = await createUserUseCase.execute(
      CreateUserParams(user: user),
    );

    failureOrUser.fold(
      (failure) =>
          emit(state.copyWith(failure: failure, formStatus: FormStatus.failed)),
      (user) {
        emit(state.copyWith(formStatus: FormStatus.success));
        usersBloc.add(GetUsersEvent());
      },
    );
  }

  Future<void> updateUser() async {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    User user = User(
      id: state.id,
      role: state.role,
      password: state.password,
      firstName: state.firstName!,
      lastName: state.lastName!,
      username: state.username!,
      email: state.email!,
    );

    final failureOrUser = await updateUserUseCase.execute(
      UpdateUserParams(user: user),
    );

    emit(
      failureOrUser.fold(
        (failure) =>
            state.copyWith(failure: failure, formStatus: FormStatus.failed),
        (user) => state.copyWith(formStatus: FormStatus.success),
      ),
    );
  }

  void changeEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void changeFirstName(String firstName) {
    emit(state.copyWith(firstName: firstName));
  }

  void changeLastName(String lastName) {
    emit(state.copyWith(lastName: lastName));
  }

  void changeUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void changePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void changeRole(UserRole role) {
    emit(state.copyWith(role: role));
  }

  void updateAutovalidateMode(AutovalidateMode? autovalidateMode) {
    emit(state.copyWith(autovalidateMode: autovalidateMode));
  }
}
