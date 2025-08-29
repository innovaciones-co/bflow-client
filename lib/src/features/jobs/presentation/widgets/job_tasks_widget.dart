import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/list_tasks_desktop_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/list_tasks_mobile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobTasksWidget extends StatelessWidget {
  const JobTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksFilterBloc, TasksFilterState>(
      builder: (context, state) {
        if (state is TasksFilterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TasksFilterLoaded) {
          var tasks = state.tasks;

          return context.isMobile || context.isSmallTablet
              ? ListTasksMobileWidget(tasks: tasks)
              : ListTasksDesktopWidget(tasks: tasks);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
