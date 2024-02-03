import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
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
    10: const FixedColumnWidth(120),
    11: const FixedColumnWidth(40),
  };
  bool _allTaskSelected = false;
  final List<Task> _tasksSelected = [];

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
            index < widget.tasks.length;
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
                      value: _tasksSelected.contains(widget.tasks[index]),
                      onChanged: (bool? value) {
                        if (value == true) {
                          setState(() {
                            _tasksSelected.add(widget.tasks[index]);
                          });
                        } else {
                          setState(() {
                            _tasksSelected.remove(widget.tasks[index]);
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
                    Text(widget.tasks[index].name),
                  ),
                  _tableCell(
                    Text(widget.tasks[index].supplier?.name ?? ''),
                  ),
                  _tableCell(
                    Row(
                      children: [
                        CustomChipWidget(
                          label: widget.tasks[index].status.toString(),
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
                    Text(widget.tasks[index].startDate?.toMonthDate() ?? ''),
                  ),
                  _tableCell(
                    Text(widget.tasks[index].endDate?.toMonthDate() ?? ""),
                  ),
                  _tableCell(
                    Text(widget.tasks[index].comments ?? ""),
                  ),
                  _tableCell(
                    Text("${widget.tasks[index].progress.toString()}%"),
                  ),
                  _tableCell(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButtonWidget(
                          onPressed: () {},
                          type: ButtonType.textButton,
                          title: "",
                          icon: Icons.edit_outlined,
                        ),
                        ActionButtonWidget(
                          onPressed: () {},
                          type: ButtonType.textButton,
                          title: "",
                          icon: Icons.delete_outline_outlined,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox.shrink(),
                ],
              ),
              /* TableRow(
              // TODO: Show subtasks
              children: [
                const Text('Checkbox'),
                const Text(""),
                const Text("Whater Meter Call Up"),
                const Text("Water Corp"),
                Row(
                  children: [
                    CustomChipWidget(
                      label: "Sent",
                      backgroundColor: AppColor.lightOrange,
                      textColor: AppColor.orange,
                    ),
                  ],
                ),
                const Text("01 Jan"),
                const Text("01 Jan"),
                const Text("01 Jan"),
                const Text("We need this task for ..."),
                const Text("100%"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.textButton,
                      title: "",
                      icon: Icons.edit_outlined,
                    ),
                    ActionButtonWidget(
                      onPressed: () {},
                      type: ButtonType.textButton,
                      title: "",
                      icon: Icons.delete_outline_outlined,
                    ),
                  ],
                ),
              ],
            ), */
            ],
          )
      ],
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Task item = widget.tasks.removeAt(oldIndex);
          widget.tasks.insert(newIndex, item);
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
}
