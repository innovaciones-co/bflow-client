part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
  @override
  List<Object> get props => [];
}

class GetUsersEvent extends UsersEvent {}

class DeleteUserEvent extends UsersEvent {
  final int userId;

  const DeleteUserEvent({required this.userId});

  @override
  List<Object> get props => [
        userId,
      ];
}
