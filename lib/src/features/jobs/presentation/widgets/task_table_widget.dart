import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/extensions/ui_extensions.dart';
import 'package:bflow_client/src/core/utils/input_formatters/range_input_formatter.dart';
import 'package:bflow_client/src/core/utils/mixins/validator.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/confirmation_widget.dart';
import 'package:bflow_client/src/core/widgets/custom_chip_widget.dart';
import 'package:bflow_client/src/core/widgets/date_picker_widget.dart';
import 'package:bflow_client/src/core/widgets/dropdown_controller_widget.dart';
import 'package:bflow_client/src/features/contacts/domain/entities/contact_entity.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/task/task_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/no_tasks_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_task_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TaskTableWidget extends StatefulWidget {
  final List<Task> tasks;
  const TaskTableWidget({super.key, required this.tasks});

  @override
  State<TaskTableWidget> createState() => _TaskTableListViewState();
}

class _TaskTableListViewState extends State<TaskTableWidget> with Validator {
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

  List<Task> initialTasks = [];

  @override
  void initState() {
    super.initState();
    initialTasks = List.of(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksBloc, TasksState>(
      listener: _onTasksStateUpdated,
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
        if (state is TasksLoaded) {
          var contacts = state.contacts;

          final mergedTasks = initialTasks.map((task) {
            final updated = state.updatedTasks.firstWhere(
              (updatedTask) => updatedTask.id == task.id,
              orElse: () => task,
            );
            return updated;
          }).toList();

          return ReorderableListView(
            header: _header(),
            onReorder: _onReorderTasks,
            children: mergedTasks
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
                      _tableRow(
                          task: task, context: context, contacts: contacts),
                    ],
                  ),
                )
                .toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _onReorderTasks(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Task updatedTask = initialTasks.removeAt(oldIndex);
    initialTasks.insert(newIndex, updatedTask);

    setState(() {
      initialTasks = initialTasks
          .mapIndexed((index, task) => task.copyWith(order: index))
          .toList();
    });

    context.read<TasksBloc>().add(AddUpdatedTasks(updatedTasks: initialTasks));
    //context.read<TasksBloc>().add(UpdateTasksEvent(tasks: initialTasks));
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
    required BuildContext context,
    required List<Contact?> contacts,
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
          child: Text('${task.order ?? 0 + 1}'),
        )),
        _tableCell(
          Tooltip(
            message: task.name,
            child: TextFormField(
              onChanged: (value) {
                context
                    .read<TasksBloc>()
                    .add(UpdateTaskDataEvent(task: task.copyWith(name: value)));
              },
              initialValue: task.name,
              enableSuggestions: false,
              autocorrect: false,
              validator: validateName,
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                filled: false,
                contentPadding:
                    EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
              ),
            ),
          ),
          paddingLeft: 1,
          paddingRight: 1,
        ),
        _tableCell(
          /* Text(
            task.supplier?.name ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ), */
          DropdownControllerWidget<Contact?>(
            items: contacts,
            getLabel: (r) => r?.name ?? "(No supplier)",
            onChanged: (supplier) {
              context.read<TasksBloc>().add(
                    UpdateTaskDataEvent(
                      task: task.copyWith(supplier: supplier),
                    ),
                  );
            },
            currentItem: task.supplier,
            editOnTable: true,
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
          DatePickerWidget(
            onChange: (value) {
              context.read<TasksBloc>().add(
                  UpdateTaskDataEvent(task: task.copyWith(startDate: value)));
            },
            initialValue: task.startDate,
            editOnTable: true,
          ),
        ),
        _tableCell(
          DatePickerWidget(
            onChange: (value) {
              context.read<TasksBloc>().add(
                  UpdateTaskDataEvent(task: task.copyWith(endDate: value)));
            },
            initialValue: task.endDate,
            editOnTable: true,
          ),
        ),
        _tableCell(
          Text(
            task.comments ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _tableCell(
          TextFormField(
            onChanged: (value) {
              context.read<TasksBloc>().add(UpdateTaskDataEvent(
                  task: task.copyWith(progress: int.tryParse(value))));
            },
            initialValue: task.progress.toString(),
            enableSuggestions: false,
            autocorrect: false,
            validator: validateProgress,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              RangeInputFormatter(),
            ],
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              filled: false,
              suffixText: ' %',
              contentPadding:
                  EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 18),
            ),
          ),
          paddingLeft: 1,
          paddingRight: 1,
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

  /* _tasksToChildrenMap(List<Task> tasks) {
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
  } */

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

  void _onTasksStateUpdated(BuildContext context, TasksState state) {
    var tasksBloc = context.read<TasksBloc>();
    var homeBloc = context.read<HomeBloc>();

    if (state is TasksLoaded) {
      setState(() {
        initialTasks = state.tasks;
      });
      var taskModified = state.updatedTasks.isNotEmpty;

      if (taskModified) {
        homeBloc.add(
          ShowFooterActionEvent(
            leading: Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: AppColor.red,
                ),
                const SizedBox(width: 10),
                Text(
                  "(${state.updatedTasks.length}) tasks have been modified",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            showCancelButton: true,
            onCancel: () {
              tasksBloc.add(GetTasksEvent(jobId: (state).tasks.first.job));
              homeBloc.add(
                HideFooterActionEvent(),
              );
            },
            actions: [
              ActionButtonWidget(
                onPressed: () {
                  tasksBloc.add(
                    UpdateTasksEvent(tasks: (state).updatedTasks),
                  );
                  homeBloc.add(
                    HideFooterActionEvent(),
                  );
                },
                type: ButtonType.elevatedButton,
                title: "Save changes",
                backgroundColor: AppColor.blue,
                foregroundColor: AppColor.white,
              )
            ],
          ),
        );
      }
    }
  }
}
