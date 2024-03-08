import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/templates/templates_cubit.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_calendar_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_widget.dart';
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
  bool _viewJobInfo = false;
  late Widget _body;

  final List<Widget> _content = [
    const JobFilesWidget(),
    const JobTasksWidget(),
    const JobCalendarWidget(),
  ];

  @override
  void initState() {
    super.initState();

    _body = _content[0];
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
          create: (context) => TasksBloc(
            context.read<JobBloc>(),
            DependencyInjection.sl(),
          ),
        ),
        BlocProvider<TasksFilterBloc>(
          create: (context) => TasksFilterBloc(
            context.read<TasksBloc>(),
          ),
        ),
        BlocProvider<TemplatesCubit>(
          create: (context) => TemplatesCubit(
            createTasksFromTemplateUseCase: DependencyInjection.sl(),
            templatesUseCase: DependencyInjection.sl(),
            tasksBloc: context.read<TasksBloc>(),
          )..loadTemplates(),
        ),
      ],
      child: Scaffold(
        body: PageContainerWidget(
          title: "Call forward",
          child: BlocBuilder<JobBloc, JobState>(
            builder: (context, state) {
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
            },
            buildWhen: (_, a) => true,
          ),
        ),
      ),
    );
  }

  Widget _jobLoaded(JobLoaded state) {
    return Column(
      children: [
        _viewJobInfo ? JobItemWidget(job: state.job) : const SizedBox.shrink(),
        _jobViewSelection(),
        const SizedBox(height: 5),
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
            title: "View all tasks",
            icon: Icons.task_outlined),
        ActionButtonWidget(
          onPressed: () => _selectView(2),
          type: ButtonType.textButton,
          title: "View Calendar",
          icon: Icons.task_outlined,
        ),
        const Spacer(),
        ActionButtonWidget(
          onPressed: () {
            setState(() {
              _viewJobInfo = !_viewJobInfo;
            });
          },
          type: ButtonType.textButton,
          title: _viewJobInfo ? "Hide Job Details" : "View Job Details",
          icon: _viewJobInfo ? Icons.arrow_circle_up : Icons.arrow_circle_down,
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
