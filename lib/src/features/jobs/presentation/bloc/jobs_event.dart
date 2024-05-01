part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();
  @override
  List<Object> get props => [];
}

class GetJobsEvent extends JobsEvent {}

class FilterJobsEvent extends JobsEvent {
  final String filter;
  const FilterJobsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class CreateJobEvent extends JobsEvent {
  final Job job;

  const CreateJobEvent({required this.job});

  @override
  List<Object> get props => [job];
}
