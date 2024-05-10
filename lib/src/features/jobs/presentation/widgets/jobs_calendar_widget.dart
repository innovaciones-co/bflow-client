import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/weekdays.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/date_utils_extension.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/task_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/config.dart';

class JobsCalendarWidget extends StatefulWidget {
  const JobsCalendarWidget({super.key});

  @override
  State<JobsCalendarWidget> createState() => _JobsCalendarWidgetState();
}

class _JobsCalendarWidgetState extends State<JobsCalendarWidget> {
  DateTime _selectedMonth = DateTime.now();
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
    return Row(
      children: [
        Flexible(
          flex: 3,
          child: Column(
            children: [
              _calendarNavigator(),
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
          flex: 2,
          child: _todayTasks(),
        ),
      ],
    );
  }

  Widget _todayTasks() {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.only(left: 15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: BlocProvider<TasksBloc>(
        create: (context) =>
            DependencyInjection.sl()..add(const GetTasksEvent()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("To do list", style: context.headlineMedium),
            const SizedBox(
              height: 25,
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is TasksLoaded) {
                  final tasks = state.tasks
                      .where((task) => _isTaskInSelectedDate(task))
                      .toList();

                  if (tasks.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                            "Excellent, you don't have pending tasks for today!"),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColor.getRandomColor(),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[i].name,
                                style: context.titleMedium,
                              ),
                              Text(tasks[i].supplier?.name ?? ''),
                              Text(
                                "${tasks[i].startDate?.toDateFormat()} - ${tasks[i].endDate?.toDateFormat()}",
                                style: context.labelSmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                if (state is TasksError) {
                  FailureWidget(failure: state.failure);
                }

                return const SizedBox();
              },
            ),
          ],
        ),
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
                          : AppColor.grey,
                ),
                padding: const EdgeInsets.all(25),
                child: _buildDay(day, context),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDay(DateTime date, BuildContext context) {
    Color color = AppColor.black;
    if (date.isSameDate(_selectedDate)) {
      color = AppColor.white;
    }
    if (date.isSameDate(_today) && !date.isSameDate(_selectedDate)) {
      return Text(
        date.day.toString(),
        textAlign: TextAlign.end,
        style: context.titleMedium?.copyWith(
          color: color,
        ),
      );
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

  bool _isTaskInSelectedDate(Task task) {
    if (task.endDate == null || task.startDate == null) {
      return true;
    }

    return _selectedDate.isBetweenDates(task.startDate!, task.endDate!);
  }

  _calendarNavigator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: _selectPreviousMonth,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          SizedBox(
            width: 220,
            child: Text(
              _selectedMonth.toMonthAndYear(),
              style: context.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: _selectNextMonth,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          const Spacer(),
          TextButton(
            onPressed: _selectCurrentMonth,
            child: Text(
              "Current month",
              style: context.headlineMedium?.copyWith(fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  void _selectPreviousMonth() {
    setState(() {
      _selectedMonth =
          _selectedMonth.subtract(Duration(days: _selectedMonth.day));
    });
  }

  void _selectNextMonth() {
    setState(() {
      _selectedMonth = DateTime(
          _selectedMonth.year, _selectedMonth.month + 1, _selectedMonth.day);
    });
  }

  void _selectCurrentMonth() {
    setState(() {
      _selectedMonth = DateTime(_today.year, _today.month, _today.day);
    });
  }
}
