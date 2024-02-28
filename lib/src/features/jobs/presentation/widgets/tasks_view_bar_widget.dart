import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_activity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TasksViewBarWidget extends StatefulWidget {
  const TasksViewBarWidget({
    super.key,
  });

  @override
  State<TasksViewBarWidget> createState() => _TasksViewBarWidgetState();
}

class _TasksViewBarWidgetState extends State<TasksViewBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text("Search"),
            Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.grey,
            ),
            _buildDropdown(context),
            _showSelectedStatus()
          ],
        ),
        Row(
          children: [
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.textButton,
              title: "Delete",
              icon: Icons.delete_outline,
              paddingHorizontal: 15,
              paddingVertical: 18,
            ),
            const SizedBox(width: 12),
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.elevatedButton,
              title: "Send task",
              icon: Icons.mail_outline,
              backgroundColor: AppColor.lightBlue,
            ),
            const SizedBox(width: 12),
            BlocBuilder<JobBloc, JobState>(
              builder: (context, state) {
                if (state is! JobLoaded) {
                  return const Center(child: Text("No active job"));
                }

                int? jobId = (state).job.id;

                return ActionButtonWidget(
                  onPressed: () => context.showLeftDialog(
                    'New Activity',
                    WriteActivityWidget(
                      jobId: jobId,
                    ),
                  ),
                  type: ButtonType.elevatedButton,
                  title: "New Activity",
                  icon: Icons.add,
                  backgroundColor: AppColor.blue,
                  foregroundColor: AppColor.white,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return BlocBuilder<TasksFilterBloc, TasksFilterState>(
      builder: (context, state) {
        if (state is! TasksFilterLoaded) {
          return const SizedBox.shrink();
        }

        return DropdownButton<TaskStatus>(
          focusColor: Colors.transparent,
          items: TaskStatus.values
              .map(
                (e) => DropdownMenuItem<TaskStatus>(
                  value: e,
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        onChanged: (bool? value) {
                          _toggleStatus(e);
                          context.pop();
                        },
                        value: state.statusFilter.contains(e),
                      ),
                      Text(e.toString()),
                    ],
                  ),
                ),
              )
              .toList(),
          onChanged: _toggleStatus,
          hint: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              const Icon(
                Icons.tune_outlined,
                size: 14,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Task Status',
                style: context.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }

  void _toggleStatus(TaskStatus? value) {
    var filterBloc = context.read<TasksFilterBloc>();
    if (filterBloc.state is! TasksFilterLoaded) {
      return;
    }

    var selection = (filterBloc.state as TasksFilterLoaded).statusFilter;
    if (selection.contains(value)) {
      selection.remove(value);
    } else {
      selection.add(value!);
    }
    filterBloc.add(UpdateFilter());

    filterBloc.add(UpdateTasks(statusFilter: selection));
  }

  _showSelectedStatus() {
    if (!context.isDesktop) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<TasksFilterBloc, TasksFilterState>(
      builder: (context, state) {
        if (state is! TasksFilterLoaded) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          constraints: const BoxConstraints(maxWidth: 650),
          child: Wrap(
            children: state.statusFilter
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Chip(
                      label: Text(
                        e.toString(),
                        style: context.bodySmall,
                      ),
                      deleteIcon: const Icon(
                        Icons.close_outlined,
                        size: 12,
                      ),
                      deleteButtonTooltipMessage: "Remove",
                      onDeleted: () => _toggleStatus(e),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
