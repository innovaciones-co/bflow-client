import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/extensions/ui_extensions.dart';
import 'package:bflow_client/src/core/widgets/custom_chip_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

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
    //3: const MaxColumnWidth(const FixedColumnWidth(100.0), FractionColumnWidth(0.1)),
    4: const FixedColumnWidth(110),
    5: const FixedColumnWidth(100),
    6: const FixedColumnWidth(100),
    7: const FixedColumnWidth(100),
    9: const FixedColumnWidth(80),
    10: const FixedColumnWidth(110),
    11: const FixedColumnWidth(40),
  };

  bool _allTaskSelected = false;
  final List<Task?> _tasksSelected = [];

  final List<Task> parentTasks = [];
  late final Map<int, List<Task>> childrenTasksMap;

  @override
  void initState() {
    super.initState();
    for (var task in widget.tasks) {
      if (task.parentTask == null) {
        parentTasks.add(task);
      }
    }
    childrenTasksMap = _tasksToChildrenMap(widget.tasks);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      header: Table(
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
              _tableCell(Checkbox(
                value: _allTaskSelected,
                onChanged: (bool? value) {
                  setState(() {
                    _allTaskSelected = value ?? false;

                    _allTaskSelected
                        ? _tasksSelected.addAll(widget.tasks)
                        : _tasksSelected.removeWhere((element) => true);
                  });
                },
                side: BorderSide(color: AppColor.darkGrey, width: 2),
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
      ),
      children: [
        for (int index = 0; index < parentTasks.length; index += 1)
          Table(
            key: Key('$index'),
            columnWidths: columnWidths,
            border: TableBorder(
              top: BorderSide(width: 0.5, color: AppColor.lightGrey),
              right: BorderSide(width: 1.0, color: AppColor.lightGrey),
              bottom: BorderSide(width: 0.5, color: AppColor.lightGrey),
              left: BorderSide(width: 1.0, color: AppColor.lightGrey),
              horizontalInside:
                  BorderSide(width: 1.0, color: AppColor.lightGrey),
              verticalInside: BorderSide(width: 1.0, color: AppColor.lightGrey),
            ),
            children: [
              _tableRow(task: parentTasks[index], index: index, parent: true),
              for (int index2 = 0;
                  index2 <
                      (childrenTasksMap[parentTasks[index].id] ?? []).length;
                  index2 += 1)
                _tableRow(
                    task: childrenTasksMap[parentTasks[index].id]![index2],
                    index: index2,
                    parent: false),
            ],
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Task item = parentTasks.removeAt(oldIndex);
          parentTasks.insert(newIndex, item);
        });
      },
    );
  }

  TableRow _tableRow(
      {required Task task, required int index, required bool parent}) {
    return TableRow(
      decoration: const BoxDecoration(
          //color: AppColor.grey,
          ),
      children: [
        _tableCell(
          parent
              ? Checkbox(
                  value: _tasksSelected.contains(task),
                  onChanged: (bool? value) {
                    if (value == true) {
                      setState(() {
                        _tasksSelected.add(task);
                      });
                    } else {
                      setState(() {
                        _tasksSelected.remove(task);
                      });
                    }
                  },
                  side: BorderSide(color: AppColor.darkGrey, width: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                )
              : const SizedBox.shrink(),
        ),
        _tableCell(
          parent
              ? Center(
                  child: Text('${index + 1}'),
                )
              : const SizedBox.shrink(),
        ),
        _tableCell(
          Row(
            children: [
              // TODO: show arrow only when parent has children
              parent
                  ? const Icon(
                      Icons.arrow_drop_down_rounded,
                      size: 20,
                    )
                  : const SizedBox(width: 30),
              Expanded(
                child: Text(
                  task.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
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
                onPressed: () {},
                color: AppColor.blue,
                icon: const Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),
              ),
              IconButton(
                onPressed: () {},
                color: AppColor.blue,
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  size: 20,
                ),
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
            bottom: 5),
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
}
