part of 'job_bloc.dart';

abstract class JobState extends Equatable {
  const JobState();

  @override
  List<Object> get props => [];
}

class JobInitial extends JobState {}

class JobLoading extends JobState {}

class JobLoaded extends JobState {
  final Job job;

  const JobLoaded({required this.job});

  @override
  List<Object> get props => [job];
}

class JobError extends JobState {
  final Failure failure;

  const JobError({required this.failure});

  @override
  List<Object> get props => [failure];
}
