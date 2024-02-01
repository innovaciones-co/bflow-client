import 'package:flutter/material.dart';

class JobTasksGanttWidget extends StatefulWidget {
  const JobTasksGanttWidget({super.key});

  @override
  State<JobTasksGanttWidget> createState() => _JobTasksGanttWidgetState();
}

class _JobTasksGanttWidgetState extends State<JobTasksGanttWidget> {
  final DateTime _selectedMonth = DateTime.now();
  final DateTime _selectedDate = DateTime.now();
  final DateTime _today = DateTime.now();

  // Get the first day of the month
  DateTime get _firstDayOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month, 1);

  // Get the last day of the month
  DateTime get _lastDayOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);

  // Calculate the first day of the first week (Sunday)
  DateTime get _firstDayOfFirstWeek =>
      _firstDayOfMonth.subtract(Duration(days: _firstDayOfMonth.weekday));

  // Calculate the last day of the last week (Saturday)
  DateTime get _lastDayOfLastWeek => _lastDayOfMonth
      .add(Duration(days: DateTime.saturday - _lastDayOfMonth.weekday));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Column(
        children: [
          const Text("Header"),
          Expanded(child: _calendarBody(context))
        ],
      ),
    );
  }

  _calendarBody(BuildContext context) {
    DateTime iteratorDate = _firstDayOfFirstWeek;
    final List<Widget> daysWidget = [];
    while (iteratorDate.isBefore(_lastDayOfLastWeek) ||
        iteratorDate.isAtSameMomentAs(_lastDayOfLastWeek)) {
      print("Iterator Date: $iteratorDate");
      // Increment the date by one day
      iteratorDate = iteratorDate.add(const Duration(days: 1));
      daysWidget.add(Container(
        child: Text(iteratorDate.day.toString()),
      ));
    }
    return GridView.count(crossAxisCount: 7, children: daysWidget);
  }
}
