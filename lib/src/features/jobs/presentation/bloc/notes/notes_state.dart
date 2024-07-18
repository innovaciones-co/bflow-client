part of 'notes_cubit.dart';

sealed class NotesState extends Equatable {
  final Note? note;

  const NotesState({this.note});

  @override
  List<Object> get props => [note ?? ""];
}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesChanged extends NotesState {
  const NotesChanged({required super.note});
}

final class NotesError extends NotesState {
  final Failure failure;

  const NotesError({required this.failure});
}

final class NotesAdded extends NotesState {}
