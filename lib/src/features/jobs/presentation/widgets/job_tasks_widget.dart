import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/task_table_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/tasks_view_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobTasksWidget extends StatelessWidget {
  const JobTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is TasksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is TasksLoaded) {
          return _buildTasks(context, state.tasks);
        }

        if (state is TasksError) {
          return FailureWidget(failure: state.failure);
        }

        return const SizedBox.shrink();
      },
    );
  }

  _buildTasks(BuildContext context, List<Task> tasks) {
    return Expanded(
      child: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            const TasksViewBarWidget(),
            const TabBar(
              tabs: [
                Tab(text: ("Slab down")),
                Tab(text: ("Plate Height")),
                Tab(text: ("Roof Cover")),
                Tab(text: ("Lock UP")),
                Tab(text: ("Cabinets")),
                Tab(text: ("PCI")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  context.isDesktop
                      ? TaskTableWidget(
                          tasks: tasks,
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 1500, // TODO: Implement a valid width
                            child: TaskTableWidget(
                              tasks: tasks,
                            ),
                          ),
                        ),
                  const Text("Plate Height"),
                  const Text("Roof Cover"),
                  const Text("Lock UP"),
                  const Text("Cabinets"),
                  const Text("PCI"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
