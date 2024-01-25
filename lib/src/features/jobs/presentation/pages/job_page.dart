import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/core/widgets/switch_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_tasks_calendar_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/job_files_widget.dart';

class JobPage extends StatefulWidget {
  final int jobId;
  const JobPage({super.key, required this.jobId});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  late Widget _body;

  final List<Widget> _content = [
    const JobFilesWidget(),
    const JobTasksWidget(),
    const JobTasksCalendarWidget(),
  ];

  @override
  void initState() {
    super.initState();

    _body = _content.first;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JobBloc>(
          create: (context) =>
              DependencyInjection.sl()..add(GetJobEvent(id: widget.jobId)),
        ),
        BlocProvider<TasksBloc>(
            create: (context) =>
                TasksBloc(context.read<JobBloc>(), DependencyInjection.sl())),
      ],
      child: Scaffold(
        body: PageContainerWidget(
          title: "Call forward",
          child: BlocBuilder<JobBloc, JobState>(builder: (context, state) {
            if (state is JobLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is JobLoaded) {
              return _jobLoaded(state);
            }

            if (state is JobError) {
              return FailureWidget(failure: state.failure);
            }

            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }

  Widget _jobLoaded(JobLoaded state) {
    return Column(
      children: [
        JobItemWidget(job: state.job),
        _jobViewSelection(),
        const FilterTasksWidget(),
        _body
      ],
    );
  }

  Widget _jobViewSelection() {
    return Row(
      children: [
        ActionButtonWidget(
            onPressed: () => _selectView(0),
            type: ButtonType.textButton,
            title: "View jobs documents",
            icon: Icons.all_inbox_sharp),
        ActionButtonWidget(
            onPressed: () => _selectView(1),
            type: ButtonType.textButton,
            title: "View all task",
            icon: Icons.task_outlined),
        ActionButtonWidget(
            onPressed: () => _selectView(2),
            type: ButtonType.textButton,
            title: "View Calendar",
            icon: Icons.task_outlined),
        const SwitchWidget(
          title: "View calendar",
        ),
      ],
    );
  }

  void _selectView(int index) {
    setState(() {
      _body = _content[index];
    });
  }
}

class FilterTasksWidget extends StatelessWidget {
  const FilterTasksWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Search"),
        ActionButtonWidget(
          onPressed: () {},
          type: ButtonType.textButton,
          title: "Filter",
          icon: Icons.tune,
          foregroundColor: Colors.black,
        ),
        const Text("Water Meter call up"),
        ActionButtonWidget(
            onPressed: () {},
            type: ButtonType.textButton,
            title: "Delete",
            icon: Icons.delete_outline),
        ActionButtonWidget(
          onPressed: () {},
          type: ButtonType.elevatedButton,
          title: "Send task",
          icon: Icons.mail_outline,
          backgroundColor: Colors.blue.shade50,
        ),
        const SizedBox(width: 12),
        ActionButtonWidget(
          onPressed: () {},
          type: ButtonType.elevatedButton,
          title: "New Activity",
          icon: Icons.add,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}
