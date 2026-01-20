import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/task_table_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/tasks_view_bar_widget.dart';
import 'package:flutter/material.dart';

class ListTasksDesktopWidget extends StatelessWidget {
  final List<Task> tasks;
  const ListTasksDesktopWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const TasksViewBarWidget(),
          Expanded(
            child: context.isDesktop
                ? TaskTableWidget(tasks: tasks)
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 1500,
                      child: TaskTableWidget(tasks: tasks),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
