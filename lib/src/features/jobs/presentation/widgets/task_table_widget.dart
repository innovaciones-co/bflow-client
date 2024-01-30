import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/custom_chip_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:flutter/material.dart';

/// Flutter code sample

class TaskTableWidget extends StatefulWidget {
  final List<Task> tasks;
  const TaskTableWidget({super.key, required this.tasks});

  @override
  State<TaskTableWidget> createState() => _TaskTableListViewState();
}

class _TaskTableListViewState extends State<TaskTableWidget> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      header: Table(
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
            children: const [
              Text('Checkbox'),
              Text('#'),
              Text("Task"),
              Text("Suplier"),
              Text("Status"),
              Text("Call date"),
              Text("Start date"),
              Text("End date"),
              Text("Comments"),
              Text("Progress"),
              Text("Actions"),
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
                    //color: Colors.grey,
                    ),
                children: [
                  const Text('Checkbox'),
                  Text('${index + 1}'),
                  Text(widget.tasks[index].name),
                  Text(widget.tasks[index].supplier.toString()),
                  Row(children: [
                    CustomChipWidget(
                      label: widget.tasks[index].status.toString(),
                      backgroundColor: AppColor.lightOrange,
                      textColor: AppColor.orange,
                    ),
                  ]),
                  const Text("01 Jan"),
                  Text(widget.tasks[index].startDate != null
                      ? widget.tasks[index].startDate!.toString()
                      : ""),
                  Text(widget.tasks[index].endDate != null
                      ? widget.tasks[index].endDate!.toString()
                      : ""),
                  Text(widget.tasks[index].comments != null
                      ? widget.tasks[index].comments!
                      : ""),
                  Text(widget.tasks[index].progress.toString()),
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
              ),
              /* TableRow(
                // Optional subtask
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
}
