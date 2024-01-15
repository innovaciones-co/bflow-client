import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_jobs_use_case.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final GetJobsUseCase getJobsUseCase;
  JobsBloc(this.getJobsUseCase) : super(JobsInitial()) {
    on<GetJobsEvent>((event, emit) async {
      emit(JobsLoading());
      var jobs = await getJobsUseCase.execute(NoParams());
      jobs.fold(
        (l) => emit(
          JobsError(l),
        ),
        (r) => emit(
          JobsLoaded(jobs: r),
        ),
      );
    });
  }
}
