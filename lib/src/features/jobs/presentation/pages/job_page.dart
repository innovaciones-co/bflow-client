import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/failure_widget.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks/tasks_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/tasks_filter/tasks_filter_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_calendar_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_tasks_widget.dart';
import 'package:bflow_client/src/features/purchase_orders/presentation/widgets/job_materials_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/job_files_widget.dart';

class JobPage extends StatefulWidget {
  final int jobId;
  const JobPage({super.key, required this.jobId});

  @override
  State<JobPage> createState() => _JobPageState();
}

class PageSelector {
  final Widget child;
  final String title;

  PageSelector({required this.child, required this.title});
}

class _JobPageState extends State<JobPage> {
  bool _viewJobInfo = false;
  late Widget _body;
  late String _pageTitle;
  int _selectedIndex = 1;

  final List<PageSelector> _content = [
    PageSelector(child: const JobFilesWidget(), title: "Documents"),
    PageSelector(child: const JobTasksWidget(), title: "Call forward"),
    PageSelector(child: const JobCalendarWidget(), title: "Call forward"),
    PageSelector(child: JobMaterialsWidget(), title: "Bill of Materials"),
  ];

  @override
  void initState() {
    super.initState();

    _pageTitle = _content[_selectedIndex].title;
    _body = _content[_selectedIndex].child;
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
            jobBloc: context.read<JobBloc>(),
            getTasksUseCase: DependencyInjection.sl(),
            deleteTaskUseCase: DependencyInjection.sl(),
            sendTasksUseCase: DependencyInjection.sl(),
            updateTasksUseCase: DependencyInjection.sl(),
            homeBloc: context.read<HomeBloc>(),
            socketService: DependencyInjection.sl(),
            updateTaskUseCase: DependencyInjection.sl(),
            getContactsUseCase: DependencyInjection.sl(),
          ),
        ),
        BlocProvider<TasksFilterBloc>(
          create: (context) => TasksFilterBloc(
            context.read<TasksBloc>(),
          ),
        ),
      ],
      child: PageContainerWidget(
        title: _pageTitle,
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
          icon: Icons.all_inbox_sharp,
          foregroundColor: _selectedIndex == 0 ? AppColor.black : AppColor.blue,
        ),
        ActionButtonWidget(
          onPressed: () => _selectView(1),
          type: ButtonType.textButton,
          title: "View all tasks",
          icon: Icons.task_outlined,
          foregroundColor: _selectedIndex == 1 ? AppColor.black : AppColor.blue,
        ),
        ActionButtonWidget(
          onPressed: () => _selectView(2),
          type: ButtonType.textButton,
          title: "View Calendar",
          icon: Icons.calendar_today_outlined,
          foregroundColor: _selectedIndex == 2 ? AppColor.black : AppColor.blue,
        ),
        ActionButtonWidget(
          onPressed: () => _selectView(3),
          type: ButtonType.textButton,
          title: "Bill of materials",
          icon: Icons.list_alt_outlined,
          foregroundColor: _selectedIndex == 3 ? AppColor.black : AppColor.blue,
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
      _selectedIndex = index;
      _body = _content[_selectedIndex].child;
      _pageTitle = _content[_selectedIndex].title;
    });
  }
}
