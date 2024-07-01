import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/header_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TaskAction {
  confirm,
  reschedule,
  reject,
  notFound;

  factory TaskAction.fromString(String? str) {
    switch (str?.toLowerCase()) {
      case 'confirm':
        return TaskAction.confirm;
      case 'reschedule':
        return TaskAction.reschedule;
      case 'reject':
        return TaskAction.reject;
      default:
        return TaskAction.notFound;
    }
  }
}

class TaskConfirmationPage extends StatelessWidget {
  final int taskId;
  final TaskAction action;

  TaskConfirmationPage({super.key, required this.taskId, required this.action});

  final Map<TaskActionStatus, Widget> messages = {
    TaskActionStatus.newTask: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "New Task assigned",
      subTitle: "Please reply to confirm the task",
    ),
    TaskActionStatus.proposeDate: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "Propose a new date",
      subTitle: "Select the date and send it for confirmation",
    ),
    TaskActionStatus.dateProposed: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "Date Proposed",
      subTitle: "The proposed date is under review",
    ),
    TaskActionStatus.confirmTask: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "Confirm Task",
      subTitle:
          "Please confirm if you can complete the task on the proposed date",
    ),
    TaskActionStatus.taskConfirmed: HeaderMessageWidget(
      lineColor: AppColor.green,
      title: "Task Confirmed",
      subTitle: "You have confirmed the task",
    ),
    TaskActionStatus.rejectTask: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "Reject Task",
      subTitle: "You have chosen to reject the task",
    ),
    TaskActionStatus.taskRejected: HeaderMessageWidget(
      lineColor: AppColor.red,
      title: "Task Rejected",
      subTitle: "The task has been rejected",
    ),
    TaskActionStatus.error: HeaderMessageWidget(
      lineColor: AppColor.red,
      title: "Error",
      subTitle: "An error occurred, please try again",
    ),
    TaskActionStatus.taskRescheduled: HeaderMessageWidget(
      lineColor: AppColor.blue,
      title: "Task Rescheduled",
      subTitle: "The task has been rescheduled",
    ),
    TaskActionStatus.rescheduleTask: const HeaderMessageWidget(
      lineColor: Colors.transparent,
      title: "Reschedule Task",
      subTitle: "Please propose a new date for the task",
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      body: BlocProvider<TaskCubit>(
        create: (context) => DependencyInjection.sl()..loadTask(taskId),
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 15),
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _header(),
                const SizedBox(height: 10),
                _message(),
                const SizedBox(height: 10),
                _taskInfo()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<TaskCubit, TaskState> _message() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const LinearProgressIndicator();
        }

        if (state is TaskLoaded) {
          return BlocSelector<TaskCubit, TaskState, TaskActionStatus?>(
            selector: (state) {
              if (state is TaskUpdated) {
                return (state).actionStatus;
              }
              return null;
            },
            builder: (context, actionStatus) {
              if (actionStatus == null) {
                return messages[TaskActionStatus.newTask]!;
              }

              return messages[actionStatus]!;
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _taskInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskError) {
                return FailureWidget(failure: state.failure);
              }

              if (state is TaskLoaded) {
                Task task = state.task;
                Job job = state.job;
                Map<String, String> data = {
                  'Job number': job.jobNumber,
                  'Addresss': job.address,
                  'Booking Date': task.startDate.toString(),
                  'Comments': task.comments ?? "No comments",
                  'Supplier': task.supplier?.name ?? "No Supplier",
                  'Project supervisor': job.supervisor.fullName,
                  'End Date': task.endDate.toString(),
                };
                return Table(
                  columnWidths: const {
                    0: FixedColumnWidth(140),
                  },
                  children: [
                    ...data.entries.map(
                      (entry) {
                        return _tableRow(entry.key, entry.value, context);
                      },
                    ),
                  ],
                );
              }

              return const CircularProgressIndicator();
            },
          ),
          const SizedBox(height: 20),
          _actionButtons()
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
      decoration: BoxDecoration(
        color: AppColor.black,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.asset(
        'assets/img/sh_logo_and_text.png',
        height: 25,
      ),
    );
  }

  Widget _actionButtons() {
    return Builder(builder: (context) {
      TaskCubit taskCubit = context.read();

      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 15),
          ActionButtonWidget(
            onPressed: taskCubit.rejectTask,
            type: ButtonType.textButton,
            title: "Reject",
            foregroundColor: AppColor.red,
          ),
          const SizedBox(width: 15),
          ActionButtonWidget(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (picked != null && picked.isAfter(DateTime.now())) {
                taskCubit.rescheduleTask(picked);
              }
            },
            type: ButtonType.elevatedButton,
            title: "Propose date",
          ),
          const SizedBox(width: 15),
          ActionButtonWidget(
            onPressed: taskCubit.confirmTask,
            type: ButtonType.elevatedButton,
            title: "Confirm",
            backgroundColor: AppColor.blue,
            foregroundColor: AppColor.white,
          ),
        ],
      );
    });
  }

  TableRow _tableRow(String title, String subTitle, BuildContext context) {
    return TableRow(
      children: [
        _tableCell(
          Text(
            title,
            style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        _tableCell(
          Text(subTitle),
        ),
      ],
    );
  }

  Widget _tableCell(Widget widget,
      {double? paddingRight,
      double? paddingLeft,
      double? paddingTop,
      double? paddingBottom}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Padding(
        padding: EdgeInsets.only(
            right: paddingRight ?? 10,
            left: paddingLeft ?? 0,
            top: paddingTop ?? 10,
            bottom: paddingBottom ?? 10),
        child: widget,
      ),
    );
  }
}
