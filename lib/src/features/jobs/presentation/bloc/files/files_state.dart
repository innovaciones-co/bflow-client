part of 'files_cubit.dart';

sealed class FilesState extends Equatable {
  const FilesState();

  @override
  List<Object> get props => [];
}

final class FilesInitial extends FilesState {}

final class FilesLoading extends FilesState {}

final class FilesUploaded extends FilesState {}

final class FilesDeleted extends FilesState {}

final class FilesSelected extends FilesState {
  final List<File> selectedFiles;

  const FilesSelected({required this.selectedFiles});

  FilesSelected copyWith({List<File>? selectedFiles}) {
    return FilesSelected(
      selectedFiles: selectedFiles ?? this.selectedFiles,
    );
  }

  @override
  List<Object> get props => [selectedFiles];
}

final class FilesError extends FilesState {
  final Failure failure;

  const FilesError({required this.failure});
}
