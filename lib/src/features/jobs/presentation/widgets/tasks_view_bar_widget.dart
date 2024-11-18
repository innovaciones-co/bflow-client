import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_status.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_task_widget.dart';
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDropdown(context),
            Expanded(
              child: _showSelectedStatus(),
            ),
            BlocSelector<TasksBloc, TasksState, bool>(
              selector: (state) {
                if (state is TasksLoaded) {
                  return state.selectedTasks.isNotEmpty;
                }
                return false;
              },
              builder: (context, selectedTasks) {
                return Row(
                  children: [
                    selectedTasks
                        ? BlocSelector<TasksBloc, TasksState, bool>(
                            selector: (state) {
                              return state is TasksDeleting;
                            },
                            builder: (context, isLoading) {
                              return ActionButtonWidget(
                                onPressed: () {
                                  context.showCustomModal(
                                    ConfirmationWidget(
                                      title: "Delete tasks",
                                      description:
                                          "Are you sure you want to delete the selected task(s)?",
                                      onConfirm: () {
                                        context
                                            .read<TasksBloc>()
                                            .add(DeleteTasksEvent());
                                        context.pop();
                                      },
                                      confirmText: "Delete",
                                    ),
                                  );
                                },
                                type: ButtonType.textButton,
                                title: "Delete",
                                icon: Icons.delete_outline,
                                paddingHorizontal: 15,
                                paddingVertical: 18,
                                inProgress: isLoading,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 12),
                    selectedTasks
                        ? BlocSelector<TasksBloc, TasksState, bool>(
                            selector: (state) {
                              return state is TasksSending;
                            },
                            builder: (context, isLoading) {
                              return ActionButtonWidget(
                                onPressed: () => context
                                    .read<TasksBloc>()
                                    .add(SendSelectedTasksEvent()),
                                type: ButtonType.elevatedButton,
                                title: "Send tasks",
                                icon: Icons.mail_outline,
                                backgroundColor: AppColor.lightBlue,
                                inProgress: isLoading,
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 12),
                    BlocBuilder<JobBloc, JobState>(
                      builder: (context, state) {
                        if (state is! JobLoaded) {
                          return const Center(child: Text("No active job"));
                        }

                        int? jobId = (state).job.id;

                        return context.isMobile || context.isSmallTablet
                            ? const SizedBox.shrink()
                            : ActionButtonWidget(
                                onPressed: () => context.showLeftDialog(
                                  'New Activity',
                                  WriteTaskWidget(
                                    jobId: jobId!,
                                    tasksBloc: context.read(),
                                    jobBloc: context.read(),
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
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 5),
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
                      borderSide: BorderSide(color: AppColor.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(color: AppColor.grey, width: 1.5),
                    ),
                    contentPadding:
                        const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.white,
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                  ),
                ),
              ),
            ),
            /* Container(
              width: 1,
              height: 20,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              color: AppColor.grey,
            ), */
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

  void _removeStatus(TaskStatus? value) {
    var filterBloc = context.read<TasksFilterBloc>();
    if (filterBloc.state is! TasksFilterLoaded) {
      return;
    }

    var selection = (filterBloc.state as TasksFilterLoaded).statusFilter;
    selection.remove(value);

    filterBloc.add(UpdateFilter());
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
          child: Wrap(
            children: state.statusFilter
                .map(
                  (status) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Chip(
                      label: Text(
                        status.toString(),
                        style: context.bodySmall,
                      ),
                      deleteIcon: const Icon(
                        Icons.close_outlined,
                        size: 12,
                      ),
                      deleteButtonTooltipMessage: "Remove",
                      onDeleted: () => _removeStatus(status),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  void _searchTasks(String value, BuildContext context) {
    context.read<TasksBloc>().add(SearchTasks(value: value));
  }
}
