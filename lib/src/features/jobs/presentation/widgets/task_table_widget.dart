import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/extensions/ui_extensions.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/core/widgets/custom_chip_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/no_tasks_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_task_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TaskTableWidget extends StatefulWidget {
  final List<Task> tasks;
  const TaskTableWidget({super.key, required this.tasks});

  @override
  State<TaskTableWidget> createState() => _TaskTableListViewState();
}

class _TaskTableListViewState extends State<TaskTableWidget> {
  Map<int, TableColumnWidth> columnWidths = {
    0: const FixedColumnWidth(40),
    1: const FixedColumnWidth(40),
    4: const FixedColumnWidth(110),
    5: const FixedColumnWidth(100),
    6: const FixedColumnWidth(100),
    7: const FixedColumnWidth(100),
    9: const FixedColumnWidth(80),
    10: const FixedColumnWidth(110),
    11: const FixedColumnWidth(40),
  };

  List<Task> updatedTasks = [];

  @override
  void initState() {
    super.initState();
    updatedTasks = List.of(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const LoadingWidget();
        }
        // As the tasks from the widget are filtered, we should use the tasks bloc
        if (state is TasksLoaded && state.tasks.isEmpty) {
          return BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
              if (state is! JobLoaded) {
                return const SizedBox.shrink();
              }
              return NoTasksWidget(
                jobId: state.job.id!,
                tasksBloc: context.read(),
              );
            },
          );
        }

        return ReorderableListView(
          header: _header(),
          onReorder: _onReorderTasks,
          children: updatedTasks
              .map(
                (task) => Table(
                  key: Key('${task.id}'),
                  columnWidths: columnWidths,
                  border: TableBorder(
                    top: BorderSide(width: 0.5, color: AppColor.lightGrey),
                    right: BorderSide(width: 1.0, color: AppColor.lightGrey),
                    bottom: BorderSide(width: 0.5, color: AppColor.lightGrey),
                    left: BorderSide(width: 1.0, color: AppColor.lightGrey),
                    horizontalInside:
                        BorderSide(width: 1.0, color: AppColor.lightGrey),
                    verticalInside:
                        BorderSide(width: 1.0, color: AppColor.lightGrey),
                  ),
                  children: [
                    _tableRow(task: task),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }

  void _onReorderTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Task updatedTask = updatedTasks.removeAt(oldIndex);
    updatedTasks.insert(newIndex, updatedTask);

    setState(() {
      updatedTasks = updatedTasks
          .mapIndexed((index, task) => task.copyWith(order: index))
          .toList();
    });

    context.read<TasksBloc>().add(UpdateTasksEvent(tasks: updatedTasks));
  }

  void _toggleSelectedTasks({
    bool selected = false,
    required TasksBloc bloc,
    required List<Task> selectedTasks,
  }) {
    for (var task in widget.tasks) {
      if (selected) {
        bloc.add(AddSelectedTask(task: task));
      } else {
        bloc.add(RemoveSelectedTask(task: task));
      }
    }
  }

  TableRow _tableRow({
    required Task task,
  }) {
    return TableRow(
      decoration: BoxDecoration(color: task.backgroundStatusColor),
      children: [
        _tableCell(
          Builder(
            builder: (context) {
              TasksBloc tasksBloc = context.read<TasksBloc>();
              if (tasksBloc.state is! TasksLoaded) {
                return const SizedBox.shrink();
              }

              var taskSelected =
                  (tasksBloc.state as TasksLoaded).selectedTasks.contains(task);
              return Checkbox(
                value: taskSelected,
                onChanged: (val) =>
                    tasksBloc.add(ToggleSelectedTask(task: task)),
                side: BorderSide(color: AppColor.darkGrey, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
              );
            },
          ),
        ),
        _tableCell(Center(
          child: Text('${task.order + 1}'),
        )),
        _tableCell(
          Tooltip(
            message: task.name,
            child: Text(
              task.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          paddingLeft: 0,
        ),
        _tableCell(
          Text(
            task.supplier?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _tableCell(
          Row(
            children: [
              CustomChipWidget(
                label: task.status.toString(),
                backgroundColor: task.statusColor,
                textColor: task.labelStatusColor,
              ),
            ],
          ),
        ),
        _tableCell(
          Text(task.callDate?.toMonthDate() ?? ""),
        ),
        _tableCell(
          Text(task.startDate?.toMonthDate() ?? ""),
        ),
        _tableCell(
          Text(task.endDate?.toMonthDate() ?? ""),
        ),
        _tableCell(
          Text(
            task.comments ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _tableCell(
          Text("${task.progress.toString()}%"),
        ),
        _tableCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => context.showLeftDialog(
                  'Edit Activity',
                  WriteTaskWidget(
                    jobId: task.job,
                    tasksBloc: context.read(),
                    jobBloc: context.read(),
                    task: task,
                  ),
                ),
                color: AppColor.blue,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),
                tooltip: 'Edit',
              ),
              BlocProvider<TaskCubit>(
                create: (context) => TaskCubit(
                  getJobUseCase: DependencyInjection.sl(),
                  getTaskUseCase: DependencyInjection.sl(),
                  deleteTaskUseCase: DependencyInjection.sl(),
                  updateTaskUseCase: DependencyInjection.sl(),
                  tasksBloc: context.read(),
                  homeBloc: context.read(),
                ),
                child: Builder(builder: (context) {
                  return IconButton(
                    onPressed: () {
                      context.showCustomModal(
                        ConfirmationWidget(
                          title: "Delete task",
                          description:
                              "Are you sure you want to delete task \"${task.name}\"?",
                          onConfirm: () {
                            if (task.id != null) {
                              context
                                  .read<TaskCubit>()
                                  .deleteTask(task.id!, task.job);
                            }
                            context.pop();
                          },
                          confirmText: "Delete",
                        ),
                      );
                    },
                    color: AppColor.blue,
                    icon: const Icon(
                      Icons.delete_outline_outlined,
                      size: 20,
                    ),
                    tooltip: 'Delete',
                  );
                }),
              ),
            ],
          ),
        ),
        const SizedBox.shrink(),
      ],
    );
  }

  _tableCell(Widget widget, {double? paddingRight, double? paddingLeft}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(
          right: paddingRight ?? 10,
          left: paddingLeft ?? 10,
          top: 5,
          bottom: 5,
        ),
        child: widget,
      ),
    );
  }

  _tasksToChildrenMap(List<Task> tasks) {
    Map<int, List<Task>> childrenTasksMap = {};

    for (var task in tasks) {
      if (task.parentTask != null) {
        if (childrenTasksMap.containsKey(task.parentTask)) {
          childrenTasksMap[task.parentTask]!.add(task);
        } else {
          childrenTasksMap[task.parentTask!] = [task];
        }
      }
    }

    return childrenTasksMap;
  }

  bool? _checkIfAllTasksSelected(List<Task> selectedTasks) {
    if (widget.tasks.every((task) => selectedTasks.contains(task))) {
      return true;
    } else if (widget.tasks.every((task) => !selectedTasks.contains(task))) {
      return false;
    }
    return null;
  }

  _header() {
    return Table(
      columnWidths: columnWidths,
      border: TableBorder(
        right: BorderSide(width: 1.0, color: AppColor.lightGrey),
        bottom: BorderSide(width: 0.2, color: AppColor.darkGrey),
        left: BorderSide(width: 1.0, color: AppColor.lightGrey),
        verticalInside: BorderSide(width: 1.0, color: AppColor.lightGrey),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: AppColor.grey,
          ),
          children: [
            _tableCell(BlocSelector<TasksBloc, TasksState, List<Task>>(
              selector: (state) {
                if (state is TasksLoaded) {
                  return state.selectedTasks;
                }

                return [];
              },
              builder: (context, selectedTasks) {
                TasksBloc tasksBloc = context.read();
                return Checkbox(
                  tristate: true,
                  value: _checkIfAllTasksSelected(selectedTasks),
                  onChanged: (val) => _toggleSelectedTasks(
                    selected: val ?? false,
                    bloc: tasksBloc,
                    selectedTasks: selectedTasks,
                  ),
                  side: BorderSide(color: AppColor.darkGrey, width: 2),
                );
              },
            )),
            _tableCell(
              const Center(
                child: Text("#"),
              ),
            ),
            _tableCell(const Text("Task")),
            _tableCell(const Text("Supplier")),
            _tableCell(const Text("Status")),
            _tableCell(const Text("Call date")),
            _tableCell(const Text("Booking date")),
            _tableCell(const Text("Completion date")),
            _tableCell(const Text("Comments")),
            _tableCell(const Text("Progress")),
            _tableCell(const Text("Actions")),
            const SizedBox.shrink(),
          ],
        ),
      ],
    );
  }
}
