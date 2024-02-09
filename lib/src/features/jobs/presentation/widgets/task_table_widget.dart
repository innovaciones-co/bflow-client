import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
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
    widget.tasks.forEach((task) {
      if (task.parentTask == null) {
        parentTasks.add(task);
      }
    });
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
                //shape: RoundedRectangleBorder(                    borderRadius: BorderRadius.circular(3)),
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
        for (int index = 0;
            index < parentTasks.length;
            index += 1) // Num of items
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
              TableRow(
                decoration: const BoxDecoration(
                    //color: AppColor.grey,
                    ),
                children: [
                  _tableCell(
                    Checkbox(
                      value: _tasksSelected.contains(parentTasks[index]),
                      onChanged: (bool? value) {
                        if (value == true) {
                          setState(() {
                            _tasksSelected.add(parentTasks[index]);
                          });
                        } else {
                          setState(() {
                            _tasksSelected.remove(parentTasks[index]);
                          });
                        }
                      },
                    ),
                  ),
                  _tableCell(
                    Center(
                      child: Text('${index + 1}'),
                    ),
                  ),
                  _tableCell(
                    Text(parentTasks[index].name),
                  ),
                  _tableCell(
                    Text(parentTasks[index].supplier?.name ?? ''),
                  ),
                  _tableCell(
                    Row(
                      children: [
                        CustomChipWidget(
                          label: parentTasks[index].status.toString(),
                          backgroundColor: AppColor.lightOrange,
                          textColor: AppColor.orange,
                        ),
                      ],
                    ),
                  ),
                  _tableCell(
                    const Text("01 Jan"),
                  ),
                  _tableCell(
                    Text(parentTasks[index].startDate?.toMonthDate() ?? ""),
                  ),
                  _tableCell(
                    Text(parentTasks[index].endDate?.toMonthDate() ?? ""),
                  ),
                  _tableCell(
                    Text(
                        "Id: ${parentTasks[index].id.toString()} -- ${childrenTasksMap[parentTasks[index].id]}"), //Text(parentsTasks[index].comments ?? ""),
                  ),
                  _tableCell(
                    Text("${parentTasks[index].progress.toString()}%"),
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
              ),
              // TODO: Show subtasks
              for (int index2 = 0;
                  index2 <
                      (childrenTasksMap[parentTasks[index].id] ?? []).length;
                  index2 += 1)
                TableRow(
                  decoration: const BoxDecoration(
                      //color: AppColor.grey,
                      ),
                  children: [
                    _tableCell(
                      const Center(
                        child: Text('X'),
                      ),
                    ),
                    _tableCell(
                      const Center(
                        child: Text('X'),
                      ),
                    ),
                    _tableCell(
                      Text(childrenTasksMap[parentTasks[index].id]![index2]
                          .name),
                    ),
                    _tableCell(
                      Text(childrenTasksMap[parentTasks[index].id]![index2]
                              .supplier
                              ?.name ??
                          ""),
                    ),
                    _tableCell(
                      Row(
                        children: [
                          CustomChipWidget(
                            label:
                                childrenTasksMap[parentTasks[index].id]![index2]
                                    .status
                                    .toString(),
                            backgroundColor: AppColor.lightOrange,
                            textColor: AppColor.orange,
                          ),
                        ],
                      ),
                    ),
                    _tableCell(
                      const Text("01 Jan"),
                    ),
                    _tableCell(
                      Text(childrenTasksMap[parentTasks[index].id]![index2]
                              .startDate
                              ?.toMonthDate() ??
                          ""),
                    ),
                    _tableCell(
                      Text(childrenTasksMap[parentTasks[index].id]![index2]
                              .endDate
                              ?.toMonthDate() ??
                          ""),
                    ),
                    _tableCell(
                      Text(
                          "Papa:${childrenTasksMap[parentTasks[index].id]![index2].parentTask.toString()}"), //Text(taskChildrenMap[parentsTasks[index].id]![index2].comments ?? ""),
                    ),
                    _tableCell(
                      Text(
                          "${childrenTasksMap[parentTasks[index].id]![index2].progress.toString()}%"),
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
                ),
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

  _tableCell(Widget widget) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: widget,
      ),
    );
  }

  _tasksToChildrenMap(List<Task> tasks) {
    Map<int, List<Task>> childrenTasksMap = {};

    // Vincular tareas con sus tareas padre
    tasks.forEach((task) {
      if (task.parentTask != null) {
        if (childrenTasksMap.containsKey(task.parentTask)) {
          // Si la clave existe, agregamos el nuevo Task a la lista correspondiente
          childrenTasksMap[task.parentTask]!.add(task);
        } else {
          // Si la clave no existe, creamos una nueva lista y agregamos el Task a esa lista
          childrenTasksMap[task.parentTask!] = [task];
        }
      }
    });

    /* taskMap.forEach((key, value) {
    print('Parent: $key');
    value.forEach((value2) {
      print('\t\tChildren: ${value2.id} - ${value2.name}');
    });
  }); */

    return childrenTasksMap;
  }
}
