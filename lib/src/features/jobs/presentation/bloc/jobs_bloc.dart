
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:equatable/equatable.dart';
  
  part 'jobs_event.dart';
  part 'jobs_state.dart';
  
  class JobsBloc extends Bloc<JobsEvent, JobsState> {
    JobsBloc() : super(JobsInitial()) {
      on<JobsEvent>((event, emit) {
        // TODO: implement event handler
      });
    }
  }
