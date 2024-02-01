import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/weekdays.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/date_utils_extension.dart';
import 'package:flutter/material.dart';

class JobsCalendarWidget extends StatefulWidget {
  const JobsCalendarWidget({super.key});

  @override
  State<JobsCalendarWidget> createState() => _JobsCalendarWidgetState();
}

class _JobsCalendarWidgetState extends State<JobsCalendarWidget> {
  final DateTime _selectedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  final DateTime _today = DateTime.now();

  DateTime get _firstDayOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month, 1);

  DateTime get _lastDayOfMonth =>
      DateTime(_selectedMonth.year, _selectedMonth.month + 1, 0);

  DateTime get _firstDayOfFirstWeek =>
      _firstDayOfMonth.subtract(Duration(days: _firstDayOfMonth.weekday));

  DateTime get _lastDayOfLastWeek => _lastDayOfMonth
      .add(Duration(days: DateTime.saturday - _lastDayOfMonth.weekday));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: GridView.count(
                    crossAxisCount: 7,
                    children: WeekDays.values
                        .map(
                          (e) => Text(e.toString()),
                        )
                        .toList(),
                  ),
                ),
                Expanded(child: _calendarBody(context))
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              color: AppColor.orange,
              height: double.maxFinite,
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 15),
              padding: const EdgeInsets.all(15),
              child: const Text("The tasks here"),
            ),
          ),
        ],
      ),
    );
  }

  _calendarBody(BuildContext context) {
    DateTime iteratorDate = _firstDayOfFirstWeek;
    final List<DateTime> days = [];
    while (iteratorDate.isBefore(_lastDayOfLastWeek) ||
        iteratorDate.isAtSameMomentAs(_lastDayOfLastWeek)) {
      // Increment the date by one day
      iteratorDate = iteratorDate.add(const Duration(days: 1));
      days.add(iteratorDate);
    }
    return GridView.count(
      crossAxisCount: 7,
      children: days
          .map(
            (day) => InkWell(
              onTap: () => _updateSelectedDate(day),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: day.month == _selectedMonth.month
                        ? AppColor.lightGrey
                        : AppColor.white,
                  ),
                  color: day.isSameDate(_selectedDate)
                      ? AppColor.purple
                      : day.month == _selectedMonth.month
                          ? AppColor.white
                          : AppColor.lightGrey,
                ),
                padding: const EdgeInsets.all(25),
                child: _buildDay(day, context),
              ),
            ),
          )
          .toList(),
    );
  }

  Text _buildDay(DateTime date, BuildContext context) {
    Color color = AppColor.black;
    if (date.isSameDate(_selectedDate)) {
      color = AppColor.white;
    }
    if (date.isSameDate(_today) && !date.isSameDate(_selectedDate)) {
      color = AppColor.red;
    }
    return Text(
      date.day.toString(),
      textAlign: TextAlign.end,
      style: context.titleMedium?.copyWith(
        color: color,
      ),
    );
  }

  void _updateSelectedDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }
}
