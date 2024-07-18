part of 'jobs_bloc.dart';

abstract class JobsEvent extends Equatable {
  const JobsEvent();
  @override
  List<Object> get props => [];
}

class GetJobsEvent extends JobsEvent {
  final DateTime timestamp;

  GetJobsEvent({DateTime? timestamp}) : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object> get props => [timestamp];
}

class FilterJobsEvent extends JobsEvent {
  final String filter;
  const FilterJobsEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class DeleteJobEvent extends JobsEvent {
  final Job job;

  const DeleteJobEvent({required this.job});
}
