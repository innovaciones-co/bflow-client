import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/form_status.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/input_formatters/range_input_formatter.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_controller_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/input_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/write_task/write_task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/file_attach_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteTaskWidget extends StatelessWidget with Validator {
  final _formKey = GlobalKey<FormState>();
  final int jobId;
  final Task? task;
  final TasksBloc tasksBloc;
  final JobBloc jobBloc;

  WriteTaskWidget(
      {super.key,
      required this.jobId,
      this.task,
      required this.tasksBloc,
      required this.jobBloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WriteTaskCubit>(
      create: (alertContext) => WriteTaskCubit(
        task: task,
        getContactsUseCase: DependencyInjection.sl(),
        getTasksUseCase: DependencyInjection.sl(),
        createTasksUseCase: DependencyInjection.sl(),
        updateTaskUseCase: DependencyInjection.sl(),
        uploadFilesUseCase: DependencyInjection.sl(),
        homeBloc: DependencyInjection.sl(),
        tasksBloc: tasksBloc,
        jobBloc: jobBloc,
        jobsBloc: DependencyInjection.sl(),
      )..initForm(jobId),
      child: BlocConsumer<WriteTaskCubit, WriteTaskState>(
        listener: (alertContext, state) {
          if (state.formStatus == FormStatus.success) {
            if (alertContext.canPop()) {
              alertContext.pop();
            }
          }
        },
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
              children: [
                state.formStatus == FormStatus.failed
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          state.failure?.message ?? 'Can\'t update task',
                          style:
                              context.bodyMedium?.copyWith(color: AppColor.red),
                        ),
                      )
                    : const SizedBox.shrink(),
                InputWidget(
                  label: "Name Task",
                  onChanged: writeTaskBloc.updateName,
                  initialValue: state.name,
                  validator: validateName,
                ),
                /* const SizedBox(height: 20),
                DropdownWidget<Task?>(
                  label: "Parent Task",
                  items: state.parentTasks,
                  getLabel: (a) => a?.name ?? '(No parent)',
                  onChanged: writeTaskBloc.updateParentTask,
                  initialValue: state.parentTask != null
                      ? state.parentTasks.firstWhere(
                          (element) => element?.id == state.parentTask)
                      : null,
                ), */
                const SizedBox(height: 20),
                Row(
                  children: [
                    Builder(builder: (context) {
                      Contact? firstWhere = state.suppliers.firstWhere(
                        (element) => element == state.supplier,
                        orElse: () => null,
                      );
                      return Expanded(
                        child: DropdownControllerWidget<Contact?>(
                          label: "Supplier",
                          items: state.suppliers,
                          getLabel: (r) => r?.name ?? "(No contact)",
                          onChanged: writeTaskBloc.updateSupplier,
                          currentItem: firstWhere,
                        ),
                      );
                    }),
                    const SizedBox(width: 20),
                    Expanded(
                      child: DropdownControllerWidget<TaskStatus>(
                        label: "Status",
                        items: TaskStatus.values,
                        getLabel: (r) => r.name,
                        onChanged: writeTaskBloc.updateStatus,
                        currentItem: state.status,
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
                        initialValue: state.stage,
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
                task != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("Attachments"),
                          ),
                          const SizedBox(height: 5),
                          FileAttachWidget(
                            taskId: task!.id!,
                            jobId: task!.job,
                            initialFiles: task?.attachments ?? [],
                            onChange: writeTaskBloc.updateAttachments,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 20,
                ),
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
                    task != null
                        ? Container(
                            margin: const EdgeInsets.only(right: 12),
                            child: ActionButtonWidget(
                              onPressed: () =>
                                  tasksBloc.add(SendTaskEvent(task: task!)),
                              type: ButtonType.elevatedButton,
                              title: "Send email",
                              backgroundColor: AppColor.lightBlue,
                            ),
                          )
                        : SizedBox.fromSize(),
                    ActionButtonWidget(
                      onPressed: () => _createOrUpdateTask(writeTaskBloc),
                      type: ButtonType.elevatedButton,
                      title: task != null ? "Update" : "Save",
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
