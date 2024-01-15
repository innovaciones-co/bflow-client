part of 'jobs_bloc.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobsInitial extends JobsState {}

class JobsLoading extends JobsState {}

class JobsLoaded extends JobsState {
  final List<Job> jobs;

  const JobsLoaded({required this.jobs});

  @override
  List<Object> get props => [jobs];
}

class JobsError extends JobsState {
  final Failure failure;

  const JobsError(this.failure);

  @override
  List<Object> get props => [failure];
}
