import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final HomeBloc? homeBloc;

  UsersBloc(this.getUsersUseCase, this.deleteUserUseCase, this.homeBloc)
      : super(UsersInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      var users = await getUsersUseCase.execute(NoParams());
      users.fold(
        (l) => emit(UsersError(failure: l)),
        (r) => emit(UsersLoaded(users: r)),
      );
    });

    on<DeleteUserEvent>(
      (event, emit) async {
        var users =
            await deleteUserUseCase.execute(DeleteUserParams(id: event.userId));
        users.fold(
          (failure) => homeBloc?.add(
            ShowMessageEvent(
                message: "Contact couldn't be deleted: ${failure.message}",
                type: AlertType.error),
          ),
          (r) {
            homeBloc?.add(
              ShowMessageEvent(
                  message: "The user was deleted!", type: AlertType.success),
            );
            add(GetUsersEvent());
          },
        );
      },
    );
  }
}
