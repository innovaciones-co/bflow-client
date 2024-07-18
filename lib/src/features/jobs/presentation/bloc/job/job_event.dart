part of 'job_bloc.dart';

abstract class JobEvent extends Equatable {
  const JobEvent();

  @override
  List<Object> get props => [];
}

class GetJobEvent extends JobEvent {
  final int id;
  const GetJobEvent({required this.id});

  @override
  List<Object> get props => [];
}
