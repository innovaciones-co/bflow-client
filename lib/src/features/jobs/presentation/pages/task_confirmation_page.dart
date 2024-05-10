import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum TaskAction {
  confirm,
  reschedule,
  reject,
  notFound;

  factory TaskAction.fromString(String? str) {
    switch (str) {
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

  const TaskConfirmationPage(
      {super.key, required this.taskId, required this.action});

  @override
  Widget build(BuildContext context) {
    /* Map<String, String> data = {}; */
    Color lineColor = Colors.transparent;
    String title = "";
    String subTitle = "";
    switch (action) {
      case TaskAction.confirm:
        lineColor = AppColor.green;
        title = "The task has been confimed";
        subTitle = "Thank you!";
        break;
      case TaskAction.reschedule:
        lineColor = Colors.transparent;
        title = "Propose a new date";
        subTitle = "Select the date and send it for confirmation";
        break;
      case TaskAction.reject:
        lineColor = AppColor.red;
        title = "The task has been rejected";
        subTitle = "Contact the supervisor";
        break;
      case TaskAction.notFound:
        return const Text("Not found"); // TODO: Create no found widget
    }

    return Scaffold(
      backgroundColor: AppColor.lightGrey,
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          width: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColor.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  'assets/img/sh_logo_and_text.png',
                  height: 25,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border(
                    left: BorderSide(
                      color: lineColor,
                      width: 5,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(subTitle),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    BlocProvider<TaskCubit>(
                      create: (context) =>
                          DependencyInjection.sl()..loadTask(taskId),
                      child: BlocBuilder<TaskCubit, TaskState>(
                        builder: (context, state) {
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
                                ...data.entries.map((entry) {
                                  return _tableRow(
                                      entry.key, entry.value, context);
                                }),
                              ],
                            );
                          }
                          return const CircularProgressIndicator(); // TODO: Complete
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ActionButtonWidget(
                          onPressed: () {},
                          type: ButtonType.elevatedButton,
                          title: action != "date" ? "Close" : "Cancel",
                          backgroundColor: action != "date"
                              ? AppColor.blue
                              : AppColor.lightBlue,
                          foregroundColor:
                              action != "date" ? AppColor.white : AppColor.blue,
                        ),
                        action != "date"
                            ? const SizedBox.shrink()
                            : Wrap(
                                children: [
                                  const SizedBox(width: 15),
                                  ActionButtonWidget(
                                    onPressed: () {},
                                    type: ButtonType.elevatedButton,
                                    title: "Propose date",
                                    backgroundColor: AppColor.blue,
                                    foregroundColor: AppColor.white,
                                  )
                                ],
                              ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TableRow _tableRow(String title, String subTitle, BuildContext context) {
    return TableRow(
      children: [
        _tableCell(Text(
          title,
          style: context.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        )),
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
