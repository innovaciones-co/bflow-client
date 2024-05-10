import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/task_table_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/tasks_view_bar_widget.dart';
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
          return _buildTasks(context, tasks);
        }

        return const SizedBox.shrink();
      },
    );
  }

  _buildTasks(BuildContext context, List<Task> tasks) {
    return Expanded(
      child: Column(
        children: [
          const TasksViewBarWidget(),
          Expanded(
            child: DefaultTabController(
              key: GlobalKey(),
              length: TaskStage.values.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: TaskStage.values
                        .map((e) => Tab(text: e.toString()))
                        .toList(),
                    labelColor: AppColor.blue,
                    indicatorColor: AppColor.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                  ),
                  Expanded(
                    child: TabBarView(
                      // TODO: Keep state when task o diferent tab is selected
                      children: TaskStage.values
                          .map(
                            (stage) => context.isDesktop
                                ? TaskTableWidget(
                                    tasks: _getFilteredTasks(tasks, stage),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      width:
                                          1500, // TODO: Implement a valid width
                                      child: TaskTableWidget(
                                        tasks: _getFilteredTasks(tasks, stage),
                                      ),
                                    ),
                                  ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Task> _getFilteredTasks(List<Task> tasks, TaskStage e) {
    return tasks.where((element) => element.stage == e).toList();
  }
}
