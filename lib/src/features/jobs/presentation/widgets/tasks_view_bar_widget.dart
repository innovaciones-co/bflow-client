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
  late Set<TaskStatus> selection;

  @override
  void initState() {
    super.initState();
    selection = TaskStatus.values.toSet();
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

  DropdownButton<TaskStatus> _buildDropdown(BuildContext context) {
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
                    value: selection.contains(e),
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
  }

  void _toggleStatus(TaskStatus? value) {
    if (selection.contains(value)) {
      setState(() {
        selection.remove(value);
      });
    } else {
      setState(() {
        selection.add(value!);
      });
    }

    var filterBloc = context.read<TasksFilterBloc>();
    filterBloc.add(UpdateTasks(status: selection));
  }

  _showSelectedStatus() {
    if (!context.isDesktop) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      constraints: const BoxConstraints(maxWidth: 650),
      child: Wrap(
        children: selection
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
  }
}
