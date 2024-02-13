import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_bloc.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/table_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobCalendarWidget extends StatefulWidget {
  const JobCalendarWidget({super.key});

  @override
  State<JobCalendarWidget> createState() => _JobCalendarWidgetState();
}

class _JobCalendarWidgetState extends State<JobCalendarWidget> {
  final double columnWidth = 110;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoaded) {
          Job job = state.job;

          return _buildTable(job.plannedStartDate, job.plannedEndDate);
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

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TasksLoaded) {
          return Row(
            children: [
              _buildFirstColumn(state),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Expanded(
                    child: Column(
                      children: [
                        _buildRowHeader(days),
                        ..._buildRows(context, days, state.tasks)
                      ],
                    ),
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
        color: AppColor.grey,
      ),
      columnWidths: {
        for (var e in days) days.indexOf(e): FixedColumnWidth(columnWidth)
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: days
              .map((e) => TableHeaderWidget(label: e.toDateFormat()))
              .toList(),
        ),
      ],
    );
  }

  Table _buildFirstColumn(TasksLoaded state) {
    return Table(
      border: TableBorder.all(
        color: AppColor.grey,
      ),
      columnWidths: const {0: FixedColumnWidth(400)},
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: const [
            TableHeaderWidget(label: "Tasks"),
          ],
        ),
        ...state.tasks.map(
          (e) => TableRow(
            children: [
              SizedBox(
                height: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(e.name),
                ),
              )
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
                  inside: BorderSide(
                    color: AppColor.grey,
                  ),
                ),
                columnWidths: {
                  for (var e in days)
                    days.indexOf(e): FixedColumnWidth(columnWidth)
                },
                children: [
                  TableRow(
                    children: days
                        .map(
                          (e) => const SizedBox(
                            height: 30,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: (task.startDate?.difference(firtsDay).inDays.toDouble() ??
                        0) *
                    columnWidth,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.getRandomColor(),
                  ),
                  width: (task.endDate
                              ?.difference(task.startDate!)
                              .inDays
                              .toDouble() ??
                          0) *
                      columnWidth,
                  child: Center(
                    child: Text(
                      task.name,
                      style:
                          context.bodyMedium?.copyWith(color: AppColor.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        .toList();
  }
}
