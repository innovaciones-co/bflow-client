
  part of 'jobs_bloc.dart';
  
  abstract class JobsState extends Equatable {
    const JobsState();
    
    @override
    List<Object> get props => [];
  }
  class JobsInitial extends JobsState {}
  