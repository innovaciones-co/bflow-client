import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_stage.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/task_table_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/tasks_view_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobTasksWidget extends StatelessWidget {
  const JobTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksBloc, TasksState>(
      listener: (context, state) {
        /* if (state is TasksLoaded) {
          if (!state.tasksUpdated) {
            return;
          }

          HomeBloc homeBloc = context.read();
          homeBloc.add(
            const ShowFooterActionEvent(
              actions: [
                ElevatedButton(onPressed: null, child: Text("Save")),
              ],
              leading: Text("Update (10) selected tasks"),
            ),
          );
        } */
      },
      child: BlocBuilder<TasksFilterBloc, TasksFilterState>(
        builder: (context, state) {
          if (state is TasksFilterLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TasksFilterLoaded) {
            var tasks = state.tasks;
            var tabIndex = state.tabIndex;
            return _buildTasks(context, tasks, tabIndex);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  _buildTasks(BuildContext context, List<Task> tasks, int tabIndex) {
    return Expanded(
      child: Column(
        children: [
          const TasksViewBarWidget(),
          Expanded(
            child: DefaultTabController(
              initialIndex: tabIndex,
              key: GlobalKey(),
              length: TaskStage.values.length,
              child: Column(
                children: [
                  TabBar(
                    tabs: TaskStage.values
                        .map((e) => Tab(text: e.toString()))
                        .toList(),
                    onTap: (value) => context
                        .read<TasksFilterBloc>()
                        .add(UpdateTabIndex(tabIndex: value)),
                    labelColor: AppColor.blue,
                    indicatorColor: AppColor.blue,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 3,
                  ),
                  Expanded(
                    child: TabBarView(
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
