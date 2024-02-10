import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/usecases/usecases.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/contact_type.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/create_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/domain/usecases/update_job_use_case.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/create_job_state.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_supervisors_use_case.dart';
import 'package:bflow_client/src/features/users/domain/usecases/get_users_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateJobCubit extends Cubit<CreateJobState> {
  final GetSupervisorsUseCase getSupervisorsUseCase;
  final GetUsersUseCase getUsersUseCase;
  final CreateJobUseCase createJobUseCase;
  final UpdateJobUseCase updateJobUseCase;
  final HomeBloc homeBloc;
  final JobsBloc jobsBloc;
  final Job? job;

  CreateJobCubit({
    required this.getSupervisorsUseCase,
    required this.getUsersUseCase,
    required this.createJobUseCase,
    required this.updateJobUseCase,
    required this.jobsBloc,
    required this.homeBloc,
    this.job,
  }) : super(
          CreateJobValidator(
            jobNumber: job?.jobNumber ?? '',
            name: job?.name ?? '',
            address: job?.address ?? '',
            supervisor: job?.supervisor,
            owner: job?.user,
            supervisors: job?.supervisor != null ? [job!.supervisor] : [],
            owners: job?.user != null ? [job!.user] : [],
            startDate: job?.plannedStartDate,
            endDate: job?.plannedEndDate,
          ),
        );

  void initForm() {
    emit(state.copyWith(formStatus: FormStatus.inProgress));

    getSupervisorsUseCase.execute(NoParams()).then(
          (supervisors) => {
            supervisors.fold(
              (l) {
                emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
              },
              (r) {
                emit(state.copyWith(
                    supervisors: r, formStatus: FormStatus.loaded));
              },
            ),
          },
        );

    getUsersUseCase.execute(NoParams()).then(
          (users) => {
            users.fold(
              (l) {
                emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
              },
              (r) {
                emit(state.copyWith(owners: r, formStatus: FormStatus.loaded));
              },
            ),
          },
        );
  }

  void updateJobNumber(String jobJumber) {
    emit(state.copyWith(jobNumber: jobJumber));
  }

  void updateName(String name) {
    emit(state.copyWith(name: name));
  }

  void updateAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void updateStartDate(DateTime? startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void updateEndDate(DateTime? endDate) {
    emit(state.copyWith(endDate: endDate));
  }

  void updateOwner(User owner) {
    emit(state.copyWith(owner: owner));
  }

  void updateSupervisor(User supervisor) {
    emit(state.copyWith(supervisor: supervisor));
  }

  void updateAutovalidateMode(AutovalidateMode always) {
    emit(state.copyWith(autovalidateMode: AutovalidateMode.always));
  }

  void createJob() async {
    emit(state.copyWith(
      formStatus: FormStatus.inProgress,
    ));

    final params = CreateJobParams(
      job: Job(
        jobNumber: state.jobNumber,
        name: state.jobNumber,
        plannedStartDate: state.startDate ?? DateTime.now(),
        plannedEndDate:
            state.endDate ?? DateTime.now().add(const Duration(days: 30)),
        address: state.address,
        user: state.owner!,
        //TODO: Use client
        client: Contact(
            id: 10000,
            name: "Jhon Dow",
            email: "test",
            type: ContactType.client),
        supervisor: state.supervisor!,
      ),
    );
    final createJob = await createJobUseCase.execute(params);
    createJob.fold(
      (l) {
        emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
      },
      (r) {
        emit(state.copyWith(formStatus: FormStatus.success));
        jobsBloc.add(GetJobsEvent());
        homeBloc.add(ShowMessageEvent(
          message: "Job added!",
          type: AlertType.success,
        ));
      },
    );
  }

  void updateJob(Job job) async {
    emit(state.copyWith(
      formStatus: FormStatus.inProgress,
    ));

    final params = UpdateJobParams(
      job: Job(
        id: job.id,
        jobNumber: state.jobNumber,
        name: state.jobNumber,
        plannedStartDate: state.startDate ?? DateTime.now(),
        plannedEndDate:
            state.endDate ?? DateTime.now().add(const Duration(days: 30)),
        address: state.address,
        user: state.owner!,
        //TODO: Use client
        client: Contact(
            id: 10000,
            name: "Jhon Dow",
            email: "test",
            type: ContactType.client),
        supervisor: state.supervisor!,
      ),
    );
    final updateJob = await updateJobUseCase.execute(params);
    updateJob.fold(
      (l) {
        emit(state.copyWith(formStatus: FormStatus.failed, failure: l));
      },
      (r) {
        emit(state.copyWith(formStatus: FormStatus.success));
        jobsBloc.add(GetJobsEvent(timestamp: DateTime.now()));
        homeBloc.add(ShowMessageEvent(
          message: "Job updated!",
          type: AlertType.success,
        ));
      },
    );
  }
}
