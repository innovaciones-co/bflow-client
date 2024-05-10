part of 'files_cubit.dart';

sealed class FilesState extends Equatable {
  const FilesState();

  @override
  List<Object> get props => [];
}

final class FilesInitial extends FilesState {}

final class FilesLoading extends FilesState {}

final class FilesUploaded extends FilesState {}

final class FilesError extends FilesState {
  final Failure failure;

  const FilesError({required this.failure});
}
