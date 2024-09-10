part of 'request_password_update_cubit.dart';

sealed class RequestPasswordUpdateState extends Equatable {
  final bool tokenRequested;
  const RequestPasswordUpdateState({this.tokenRequested = false});

  @override
  List<Object> get props => [tokenRequested];
}

final class RequestPasswordUpdateInitial extends RequestPasswordUpdateState {
  final String username;
  final AutovalidateMode autovalidateMode;

  const RequestPasswordUpdateInitial(
      {this.username = '', this.autovalidateMode = AutovalidateMode.disabled});

  RequestPasswordUpdateInitial copyWith({
    String? username,
    AutovalidateMode? autovalidateMode,
  }) =>
      RequestPasswordUpdateInitial(
        username: username ?? this.username,
        autovalidateMode: autovalidateMode ?? this.autovalidateMode,
      );

  @override
  List<Object> get props => [username, autovalidateMode];
}

final class RequestPasswordUpdateLoading extends RequestPasswordUpdateState {}

final class RequestPasswordUpdateDone extends RequestPasswordUpdateState {
  const RequestPasswordUpdateDone({super.tokenRequested});
}

final class RequestPasswordUpdateError extends RequestPasswordUpdateState {
  final Failure failure;

  const RequestPasswordUpdateError(
      {required this.failure, super.tokenRequested});

  @override
  List<Object> get props => [failure];
}
