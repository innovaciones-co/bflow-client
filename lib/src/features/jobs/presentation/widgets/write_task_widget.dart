import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/utils/input_formatters/range_input_formatter.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/write_task/write_task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteTaskWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();
  final int jobId;
  final Task? task;
  final TasksBloc tasksBloc;

  WriteTaskWidget(
      {super.key, required this.jobId, this.task, required this.tasksBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteTaskCubit>(
      create: (context) => WriteTaskCubit(
        getContactsUseCase: DependencyInjection.sl(),
        getTasksUseCase: DependencyInjection.sl(),
        createTasksUseCase: DependencyInjection.sl(),
        updateTasksUseCase: DependencyInjection.sl(),
        homeBloc: DependencyInjection.sl(),
        tasksBloc: tasksBloc,
      )..initForm(jobId),
      child: BlocBuilder<WriteTaskCubit, WriteTaskState>(
        builder: (context, state) {
          final writeTaskBloc = context.read<WriteTaskCubit>();
          if (state.formStatus == FormStatus.initialized ||
              state.formStatus == FormStatus.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.formStatus == FormStatus.loadFailed) {
            return Center(
              child: FailureWidget(
                failure: ServerFailure(message: state.failure?.message),
              ),
            );
          }

          return Form(
            key: _formKey,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.formStatus == FormStatus.failed
                    ? Text(state.failure?.message ?? "")
                    : const SizedBox.shrink(),
                InputWidget(
                  label: "Name Task",
                  onChanged: writeTaskBloc.updateName,
                  initialValue: state.name,
                  validator: validateName,
                ),
                const SizedBox(height: 20),
                DropdownWidget<Task?>(
                  label: "Parent Task",
                  items: state.parentTasks,
                  getLabel: (a) => a?.name ?? '(No parent)',
                  onChanged: writeTaskBloc.updateParentTask,
                  initialValue: state.parentTask != null
                      ? state.parentTasks
                          .where((element) => element?.id == state.parentTask)
                          .first
                      : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownWidget<Contact?>(
                        label: "Supplier",
                        items: state.suppliers,
                        getLabel: (r) => r?.name ?? "(No contact)",
                        onChanged: writeTaskBloc.updateSupplier,
                        initialValue: state.supplier,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownWidget<TaskStatus>(
                        label: "Status",
                        items: TaskStatus.values,
                        getLabel: (r) => r.name,
                        onChanged: writeTaskBloc.updateStatus,
                        initialValue: state.taskStatus,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownWidget<TaskStage>(
                        label: "Stage",
                        items: TaskStage.values,
                        getLabel: (i) => i.name,
                        onChanged: writeTaskBloc.updateStage,
                        initialValue: state.taskStage,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: InputWidget(
                        label: "Progress",
                        keyboardType: TextInputType.number,
                        initialValue: state.progress.toString(),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          RangeInputFormatter()
                        ],
                        validator: validateProgress,
                        onChanged: writeTaskBloc.updateProgress,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DatePickerWidget(
                        label: "Booking Date",
                        onChange: writeTaskBloc.updateStartDate,
                        initialValue: state.startDate,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: DatePickerWidget(
                        label: "End Date",
                        onChange: writeTaskBloc.updateEndDate,
                        initialValue: state.endDate,
                        validator: validateEndDate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                InputWidget(
                  label: "Comments",
                  onChanged: writeTaskBloc.updateDescription,
                  initialValue: state.description,
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
                      paddingHorizontal: 15,
                      paddingVertical: 18,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.elevatedButton,
                      title: "Send email",
                      backgroundColor: AppColor.lightBlue,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () => _createOrUpdateTask(writeTaskBloc),
                      type: ButtonType.elevatedButton,
                      title: "Save",
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _createOrUpdateTask(WriteTaskCubit writeTaskCubit) {
    var validate = _formKey.currentState!.validate();
    if (validate) {
      if (task == null) {
        writeTaskCubit.createTask(jobId);
      } else {
        writeTaskCubit.updateTask(task!);
      }
    } else {
      writeTaskCubit.updateAutovalidateMode(AutovalidateMode.always);
    }
  }
}
