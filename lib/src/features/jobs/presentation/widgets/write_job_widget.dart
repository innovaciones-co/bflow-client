import 'package:bflow_client/src/core/config/injection.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/create_job_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/create_job_state.dart';

class WriteJobWidget extends StatelessWidget with Validator {
  final Job? job;
  WriteJobWidget({super.key, this.job});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController starDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateJobCubit>(
      create: (_) => CreateJobCubit(
        getSupervisorsUseCase: DependencyInjection.sl(),
        getUsersUseCase: DependencyInjection.sl(),
        createJobUseCase: DependencyInjection.sl(),
        updateJobUseCase: DependencyInjection.sl(),
        jobsBloc: context.read<JobsBloc>(),
        homeBloc: context.read<HomeBloc>(),
        job: job,
      ),
      child: BlocListener<CreateJobCubit, CreateJobState>(
        listener: (context, state) {
          if (state.formStatus == FormStatus.failed) {
            context.showAlert(
                message: state.failure?.message ?? '', type: AlertType.error);
          }

          if (state.formStatus == FormStatus.success) {
            Navigator.pop(context);
          }
        },
        child: BlocSelector<CreateJobCubit, CreateJobState, AutovalidateMode>(
          selector: (state) {
            return state.autovalidateMode;
          },
          builder: (context, autovalidateMode) {
            final createJobBloc = context.read<CreateJobCubit>();
            createJobBloc.initForm();

            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: autovalidateMode,
                child: BlocBuilder<CreateJobCubit, CreateJobState>(
                  builder: (context, state) {
                    if (state.formStatus == FormStatus.inProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.formStatus == FormStatus.failed) {
                      if (state.failure is ServerFailure) {
                        return Center(
                          child: FailureWidget(
                            failure: state.failure ?? ClientFailure(),
                            textColor: AppColor.red,
                          ),
                        );
                      }
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.formStatus == FormStatus.failed
                            ? FailureWidget(
                                failure: state.failure ?? ClientFailure(),
                                textColor: AppColor.red,
                              )
                            : const SizedBox.shrink(),
                        InputWidget(
                          label: "Job Number",
                          initialValue: state.jobNumber,
                          onChanged: createJobBloc.updateJobNumber,
                          validator: validateJobNumber,
                        ),
                        const SizedBox(height: 20),
                        InputWidget(
                          label: "Job Name",
                          initialValue: state.name,
                          onChanged: createJobBloc.updateName,
                          validator: validateName,
                        ),
                        const SizedBox(height: 20),
                        InputWidget(
                          label: "Address",
                          initialValue: state.address,
                          onChanged: createJobBloc.updateAddress,
                          validator: validateAddress,
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget<User>(
                          label: "Project supervisor",
                          items: state.supervisors,
                          getLabel: (s) => s.fullName,
                          onChanged: createJobBloc.updateSupervisor,
                          initialValue: state.supervisor,
                        ),
                        const SizedBox(height: 20),
                        DropdownWidget<User>(
                          label: "Owner name",
                          items: state.owners,
                          getLabel: (u) => u.fullName,
                          onChanged: createJobBloc.updateOwner,
                          initialValue: state.owner,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: DatePickerWidget(
                                onChange: createJobBloc.updateStartDate,
                                label: "Start Date",
                                validator: validateStartDate,
                                initialValue: state.startDate,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: DatePickerWidget(
                                onChange: createJobBloc.updateEndDate,
                                label: "End Date",
                                validator: (val) {
                                  return validateEndDate(val) ??
                                      validateStartAndEndDates(
                                          state.startDate, state.endDate);
                                },
                                initialValue: state.endDate,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ActionButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              type: ButtonType.textButton,
                              title: "Cancel",
                            ),
                            const SizedBox(width: 20),
                            ActionButtonWidget(
                              onPressed: () =>
                                  _createOrUpdateJob(createJobBloc),
                              type: ButtonType.elevatedButton,
                              title: "Save",
                              backgroundColor: AppColor.blue,
                              foregroundColor: AppColor.white,
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _createOrUpdateJob(CreateJobCubit createJobBloc) {
    var validate = _formKey.currentState!.validate();
    if (validate) {
      if (job == null) {
        createJobBloc.createJob();
      } else {
        createJobBloc.updateJob(job!);
      }
    } else {
      createJobBloc.updateAutovalidateMode(AutovalidateMode.always);
    }
  }
}
