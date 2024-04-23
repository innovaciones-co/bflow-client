import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/templates/presentation/widgets/create_from_template.dart';
import 'package:flutter/material.dart';

class NoTasksWidget extends StatelessWidget {
  final int jobId;
  final TasksBloc tasksBloc;
  const NoTasksWidget({
    super.key,
    required this.jobId,
    required this.tasksBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/no_data_found.png',
          ),
          const SizedBox(height: 15),
          Text(
            "No activities yet",
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text("Add a new activity"),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButtonWidget(
                onPressed: () {
                  createFromTemplate(
                    context: context,
                    jobId: jobId,
                    onLoading: _loadingTasks,
                    onCreated: _loadTasks,
                  );
                },
                type: ButtonType.textButton,
                title: "Create from template",
              ),
            ],
          )
        ],
      ),
    );
  }

  _loadTasks() {
    tasksBloc.add(GetTasksEvent(jobId: jobId));
  }

  _loadingTasks() {
    tasksBloc.add(LoadingTasksEvent());
  }
}
