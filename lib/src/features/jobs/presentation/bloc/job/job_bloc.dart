// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/get_job_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetJobUseCase getJobUseCase;
  final HomeBloc homeBloc;

  JobBloc(
    this.homeBloc,
    this.getJobUseCase,
  ) : super(JobInitial()) {
    on<JobEvent>((event, emit) {});

    on<GetJobEvent>((event, emit) async {
      emit(JobLoading());
      final params = GetJobParams(id: event.id);
      var job = await getJobUseCase.execute(params);
      job.fold(
        (l) => emit(
          JobError(failure: l),
        ),
        (r) {
          emit(JobLoaded(job: r));
        },
      );
    });
  }
}
