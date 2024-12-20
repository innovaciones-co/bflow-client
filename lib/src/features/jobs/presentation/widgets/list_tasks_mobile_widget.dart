import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/extensions/ui_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/core/widgets/custom_chip_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_task_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ListTasksMobileWidget extends StatelessWidget {
  final List<Task> tasks;
  const ListTasksMobileWidget({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: _onTasksStateUpdated,
      builder: (context, state) {
        TasksBloc tasksBloc = context.read();

        if (state is TasksError) {
          return FailureWidget(failure: state.failure);
        }

        if (state is TasksLoading) {
          return const LoadingWidget();
        }

        if (state is! TasksLoaded) {
          return const SizedBox();
        }

        List<Task> selectedTasks = state.selectedTasks;

        return Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ),
                          child: TextField(
                            onChanged: (val) => _searchTasks(val, context),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                borderSide:
                                    BorderSide(color: AppColor.grey, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22),
                                borderSide: BorderSide(
                                    color: AppColor.grey, width: 1.5),
                              ),
                              contentPadding: const EdgeInsets.only(
                                  top: 0, bottom: 0, right: 10),
                              isDense: true,
                              filled: true,
                              fillColor: AppColor.white,
                              prefixIcon: const Icon(Icons.search),
                              hintText: "Search",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 5),
                        ...tasks.map(
                          (task) => Builder(builder: (context) {
                            bool isSelected = selectedTasks.contains(task);
                            return _taskItemCard(tasksBloc, task, isSelected);
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _addButton(context, tasks),
            ],
          ),
        );
      },
    );
  }

  Widget _taskItemCard(TasksBloc tasksBloc, Task task, bool isSelected) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: AppColor.lightGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomChipWidget(
                        label: task.status.toString(),
                        backgroundColor: task.statusColor,
                        textColor: task.labelStatusColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        _cellFeature(
                          title: "Task",
                          flex: 1,
                          child: Text(task.name),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 25, right: 25, left: 25),
                    child: Row(
                      children: [
                        _cellFeature(
                          title: "Supplier",
                          flex: 6,
                          child: Text(task.supplier?.name ?? "(No supplier)"),
                        ),
                        _cellFeature(
                          title: "Call date",
                          flex: 4,
                          child: Text(task.callDate?.toMonthDate() ?? "-"),
                        ),
                        _cellFeature(
                          title: "Booking date",
                          flex: 4,
                          child: Text(task.endDate?.toMonthDate() ?? "-"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 15,
          right: 15,
          child: Checkbox(
            tristate: false,
            value: isSelected,
            onChanged: (val) => tasksBloc.add(ToggleSelectedTask(task: task)),
            side: BorderSide(color: AppColor.grey, width: 2),
          ),
        )
      ],
    );
  }

  Widget _addButton(BuildContext context, List<Task> tasks) {
    return context.isMobile || context.isSmallTablet
        ? Positioned(
            bottom: 30.0,
            right: 5,
            child: FloatingActionButton(
              onPressed: () => context.showLeftDialog(
                'New Activity',
                WriteTaskWidget(
                  jobId: tasks.first.job,
                  tasksBloc: context.read(),
                  jobBloc: context.read(),
                ),
              ),
              backgroundColor: AppColor.blue,
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _cellFeature(
      {required String title, required int flex, required Widget child}) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColor.darkGrey),
          ),
          const SizedBox(height: 3),
          child,
        ],
      ),
    );
  }

  void _onTasksStateUpdated(BuildContext context, TasksState state) {
    TasksBloc tasksBloc = context.read();
    HomeBloc homeBloc = context.read();

    if (state is TasksLoaded) {
      var taskModified = state.selectedTasks.isNotEmpty;
      if (taskModified) {
        homeBloc.add(
          ShowFooterActionEvent(
            showCancelButton: false,
            actions: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {
                        context.showCustomModal(
                          ConfirmationWidget(
                            title: "Delete tasks",
                            description:
                                "Are you sure you want to delete the selected task(s)?",
                            onConfirm: () {
                              tasksBloc.add(DeleteTasksEvent());
                              context.pop();
                            },
                            confirmText: "Delete",
                          ),
                        );
                        homeBloc.add(
                          HideFooterActionEvent(),
                        );
                      },
                      type: ButtonType.textButton,
                      title: "Delete",
                      icon: Icons.delete_outline,
                      paddingHorizontal: 15,
                      paddingVertical: 18,
                    ),
                    const SizedBox(width: 12),
                    ActionButtonWidget(
                      onPressed: () {
                        tasksBloc.add(SendSelectedTasksEvent());
                        homeBloc.add(
                          HideFooterActionEvent(),
                        );
                      },
                      type: ButtonType.elevatedButton,
                      title: "Send tasks",
                      icon: Icons.email_outlined,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        homeBloc.add(
          HideFooterActionEvent(),
        );
      }
    }
  }

  void _searchTasks(String value, BuildContext context) {
    context.read<TasksBloc>().add(SearchTasks(value: value));
  }
}
