import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/no_tasks_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/tasks_view_bar_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobCalendarWidget extends StatefulWidget {
  const JobCalendarWidget({super.key});

  @override
  State<JobCalendarWidget> createState() => _JobCalendarWidgetState();
}

class _JobCalendarWidgetState extends State<JobCalendarWidget> {
  final double columnWidth = 110;
  final double headerHeight = 48;
  final double rowsHeight = 35;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoaded) {
          Job job = state.job;

          return Expanded(
            child: Column(
              children: [
                const TasksViewBarWidget(),
                const SizedBox(height: 15),
                Expanded(
                  child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                    if (state is TasksLoaded && state.tasks.isEmpty) {
                      return BlocBuilder<JobBloc, JobState>(
                        builder: (context, state) {
                          if (state is! JobLoaded) {
                            return const SizedBox.shrink();
                          }
                          return NoTasksWidget(
                            jobId: state.job.id!,
                            tasksBloc: context.read(),
                          );
                        },
                      );
                    }
                    return ListView(
                      children: [
                        _buildTable(job.plannedStartDate, job.plannedEndDate),
                      ],
                    );
                  }),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildTable(DateTime plannedStartDate, DateTime plannedEndDate) {
    DateTime iteratorDate = plannedStartDate;
    final List<DateTime> days = [];
    while (iteratorDate.isBefore(plannedEndDate) ||
        iteratorDate.isAtSameMomentAs(plannedEndDate)) {
      // Increment the date by one day
      days.add(iteratorDate);
      iteratorDate = iteratorDate.add(const Duration(days: 1));
    }

    return BlocBuilder<TasksFilterBloc, TasksFilterState>(
      builder: (context, state) {
        if (state is TasksFilterLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFirstColumn(state.tasks),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      _buildRowHeader(days),
                      ..._buildRows(context, days, state.tasks)
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Table _buildRowHeader(List<DateTime> days) {
    return Table(
      border: TableBorder.all(
        color: Colors.transparent,
      ),
      columnWidths: {
        for (var e in days) days.indexOf(e): FixedColumnWidth(columnWidth)
      },
      children: [
        TableRow(
          children: days
              .map((e) => _tableCell(SizedBox(
                    height: headerHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          e.toDay(),
                          style: TextStyle(
                            color: AppColor.darkGrey,
                          ),
                        ),
                        Text(e.toMonthDate()),
                      ],
                    ),
                  )))
              .toList(),
        ),
      ],
    );
  }

  Table _buildFirstColumn(List<Task> tasks) {
    bool isSelected = false;

    return Table(
      border: TableBorder.all(
        color: AppColor.lightGrey,
      ),
      columnWidths: const {
        0: FixedColumnWidth(40),
        1: FixedColumnWidth(40),
        2: FixedColumnWidth(250),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: [
            _tableCell(Checkbox(
              // TODO: Implement Checkbox for all
              value: isSelected,
              onChanged: (bool? value) {
                isSelected;
              },
              side: BorderSide(color: AppColor.darkGrey, width: 2),
            )),
            _tableCell(Container(
              height: headerHeight,
              alignment: Alignment.center,
              child: const Center(child: Text("#")),
            )),
            _tableCell(const Text("Tasks")),
          ],
        ),
        ...tasks.asMap().entries.map(
              (e) => TableRow(
                children: [
                  _tableCell(
                    BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        TasksBloc tasksBloc = context.read<TasksBloc>();
                        if (state is! TasksLoaded) {
                          return const SizedBox.shrink();
                        }

                        var taskSelected =
                            state.selectedTasks.contains(e.value);
                        return Checkbox(
                          value: taskSelected,
                          onChanged: (val) =>
                              tasksBloc.add(ToggleSelectedTask(task: e.value)),
                          side: BorderSide(color: AppColor.darkGrey, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        );
                      },
                    ),
                  ),
                  _tableCell(Container(
                    height: rowsHeight,
                    alignment: Alignment.center,
                    child: Text('${int.parse(e.key.toString()) + 1}'),
                  )),
                  _tableCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Tooltip(
                            message: e.value.name,
                            child: Text(
                              e.value.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                            onPressed: () => context.showLeftDialog(
                              'Edit Activity',
                              WriteTaskWidget(
                                jobId: e.value.job,
                                tasksBloc: context.read(),
                                jobBloc: context.read(),
                                task: e.value,
                              ),
                            ),
                            color: AppColor.blue,
                            icon: const Icon(
                              Icons.edit_outlined,
                              size: 15,
                            ),
                            tooltip: 'Edit',
                            padding: const EdgeInsets.all(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
      ],
    );
  }

  List<Widget> _buildRows(
      BuildContext context, List<DateTime> days, List<Task> tasks) {
    DateTime firtsDay = days.first;

    return tasks
        .map(
          (task) => Stack(
            children: [
              Table(
                border: TableBorder.symmetric(
                  inside: BorderSide(color: AppColor.lightGrey),
                  outside: BorderSide(width: 0.5, color: AppColor.lightGrey),
                ),
                columnWidths: {
                  for (var e in days)
                    days.indexOf(e): FixedColumnWidth(columnWidth)
                },
                children: [
                  TableRow(
                    children: days
                        .map(
                          (e) => _tableCell(SizedBox(
                            height: rowsHeight,
                          )),
                        )
                        .toList(),
                  ),
                ],
              ),
              _buildProgressBar(task, firtsDay, context)
            ],
          ),
        )
        .toList();
  }

  Positioned _buildProgressBar(
      Task task, DateTime firtsDay, BuildContext context) {
    return Positioned(
      top: 8,
      bottom: 8,
      left: (task.startDate?.difference(firtsDay).inDays.toDouble() ?? 0) *
          columnWidth,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.getRandomColor(),
        ),
        width:
            (task.endDate?.difference(task.startDate!).inDays.toDouble() ?? 0) *
                columnWidth,
        child: Center(
          child: Text(
            task.name,
            style: context.bodyMedium
                ?.copyWith(color: AppColor.black.withOpacity(0.4)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _tableCell(Widget widget, // TODO: Move to TableHeaderWidget
      {double? paddingRight,
      double? paddingLeft,
      double? paddingTop,
      double? paddingBottom}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(
            right: paddingRight ?? 10,
            left: paddingLeft ?? 10,
            top: paddingTop ?? 5,
            bottom: paddingBottom ?? 5),
        child: widget,
      ),
    );
  }
}
