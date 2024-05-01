import 'dart:async';

import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/string_utils_extension.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_job_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_jobs_use_case.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';

class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final GetJobsUseCase getJobsUseCase;
  final CreateJobUseCase createJobUseCase;
  final HomeBloc homeBloc;

  JobsBloc(this.getJobsUseCase, this.createJobUseCase, this.homeBloc)
      : super(JobsInitial()) {
    on<GetJobsEvent>(_onGetJobsEvent);
    on<FilterJobsEvent>(_onFilterJobsEvent);
    on<CreateJobEvent>(_onCreateJobEvent);
  }

  FutureOr<void> _onCreateJobEvent(event, emit) async {
    var createJobParams = CreateJobParams(job: event.job);
    var job = await createJobUseCase.execute(createJobParams);
    job.fold(
      (l) => const AlertMessage(
        message: "There was a failure creating the job",
        type: AlertType.error,
      ),
      (r) {
        emit(
          const AlertMessage(
            message: "Job was created successfully",
            type: AlertType.success,
          ) as JobsState,
        );
      },
    );
  }

  FutureOr<void> _onFilterJobsEvent(event, emit) async {
    if (state is JobsLoaded) {
      var jobsLoaded = state as JobsLoaded;

      emit(jobsLoaded.copyWith(filter: event.filter));
    }
  }

  FutureOr<void> _onGetJobsEvent(event, emit) async {
    emit(JobsLoading());
    var jobs = await getJobsUseCase.execute(NoParams());
    jobs.fold(
        (l) => emit(
              JobsError(l),
            ), (r) {
      emit(JobsLoaded(jobs: r));
      homeBloc.add(const ShowMessageEvent(message: "Jobs loaded!"));
    });
  }
}
