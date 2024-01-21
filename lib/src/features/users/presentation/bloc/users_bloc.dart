import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase getUsersUseCase;
  UsersBloc(this.getUsersUseCase) : super(UsersInitial()) {
    on<GetUsersEvent>((event, emit) async {
      emit(UsersLoading());
      var users = await getUsersUseCase.execute(NoParams());
      users.fold(
        (l) => emit(UsersError(failure: l)),
        (r) => emit(UsersLoaded(users: r)),
      );
    });
  }
}
