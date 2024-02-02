import 'package:flutter/material.dart';

class JobTasksGanttWidget extends StatefulWidget {
  const JobTasksGanttWidget({super.key});

  @override
  State<JobTasksGanttWidget> createState() => _JobTasksGanttWidgetState();
}

class _JobTasksGanttWidgetState extends State<JobTasksGanttWidget> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 400,
      child: Column(
        children: [
          Text("Header"),
        ],
      ),
    );
  }
}
