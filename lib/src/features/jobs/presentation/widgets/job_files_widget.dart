import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

class JobFilesWidget extends StatelessWidget {
  const JobFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      //height: 100,
      child: DefaultTabController(
        length: 6,
        child: Scaffold(
          body: Column(
            children: [
              TabBar(
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
                    TaskTableWidget(),
                    Text("Plate Height"),
                    Text("Roof Cover"),
                    Text("Lock UP"),
                    Text("Cabinets"),
                    Text("PCI"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Flutter code sample

class TaskTableWidget extends StatefulWidget {
  const TaskTableWidget({super.key});

  @override
  State<TaskTableWidget> createState() => _TaskTableListViewState();
}

class _TaskTableListViewState extends State<TaskTableWidget> {
  final List<dynamic> _tableList = ['Bob', 'Cindy+', 'Duke', 'Ellenina', ''];

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
              Text('#'),
              Text("Task"),
              Text("Suplier"),
              Text("Call date"),
              Text("Booking date"),
              Text("Booking date"),
              Text("Comments"),
              Text("Progress"),
            ],
          ),
        ],
      ),
      children: [
        for (int index = 0;
            index < _tableList.length;
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
                  Text('${index + 1}'),
                  const Text("Whater Meter Call Up"),
                  const Text("Water Corp"),
                  const Text("01 Jan"),
                  const Text("01 Jan"),
                  const Text("01 Jan"),
                  const Text("We need this task for ..."),
                  const Text("100%"),
                ],
              ),
              const TableRow(
                // Optional subtask
                children: [
                  Text(""),
                  Text("Whater Meter Call Up"),
                  Text("Water Corp"),
                  Text("01 Jan"),
                  Text("01 Jan"),
                  Text("01 Jan"),
                  Text("We need this task for ..."),
                  Text("100%"),
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
          final List item = _tableList.removeAt(oldIndex);
          _tableList.insert(newIndex, item);
        });
      },
    );
  }
}
