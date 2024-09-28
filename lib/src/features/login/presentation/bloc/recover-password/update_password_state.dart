import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:equatable/equatable.dart';

class UpdatePasswordState extends Equatable {
  final bool isLoading;
  final String? message;
  final Failure? error;

  const UpdatePasswordState({
    this.isLoading = false,
    this.message,
    this.error,
  });

  UpdatePasswordState copyWith({
    bool? isLoading,
    String? message,
    Failure? error,
  }) {
    return UpdatePasswordState(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, message, error];
}
