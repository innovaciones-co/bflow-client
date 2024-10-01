import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/domain/entities/alert_type.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/core/widgets/switch_widget.dart';
import 'package:bflow_client/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_mobile_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/jobs_calendar_widget.dart';
import 'package:bflow_client/src/features/shared/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/job_item_desktop_widget.dart';
import '../widgets/jobs_action_bar_widget.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  bool _calendarView = false;

  @override
  void initState() {
    context.read<JobsBloc>().add(GetJobsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainerWidget(
        title: "Jobs",
        actions: [
          SwitchWidget(
            value: _calendarView,
            onChanged: _switchView,
            title: "View calendar",
          ),
        ],
        child: !_calendarView
            ? _jobsGeneralView(context)
            : const JobsCalendarWidget(),
      ),
    );
  }

  Widget _jobsGeneralView(BuildContext context) {
    return BlocConsumer<JobsBloc, JobsState>(
      listener: (context, state) {
        if (state is JobsError) {
          HomeBloc homeBloc = context.read();
          homeBloc.add(
            ShowMessageEvent(
                message: state.failure.message ?? 'Unexpected error',
                type: AlertType.error),
          );
          JobsBloc jobsBloc = context.read();
          jobsBloc.add(GetJobsEvent());
        }
      },
      builder: (context, state) {
        if (state is JobsInitial) {
          return const SizedBox.shrink();
        }

        if (state is JobsError) {
          final message = state.failure.message ?? "Unexpected error";
          return Center(
            child: Text(message),
          );
        }

        if (state is JobsLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _getJobCards(context),
                context.isMobile || context.isSmallTablet
                    ? const SizedBox.shrink()
                    : const JobsActionBarWidget(),
                Column(
                  children: state.jobsFiltered
                      .map(
                        (job) => context.isMobile || context.isSmallTablet
                            ? JobItemMobileWidget(
                                job: job,
                                viewDetailsEnabled: true,
                              )
                            : JobItemDesktopWidget(
                                job: job,
                                viewDetailsEnabled: true,
                              ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        }

        return const LoadingWidget();
      },
    );
  }

  Widget _jobsTotalCard(
    BuildContext context, {
    required Color color,
    required Color borderColor,
    required String title,
    required String total,
    required String imagePath,
  }) {
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.isSmallTablet ? 15 : 20,
                  vertical:
                      context.isMobile || context.isSmallTablet ? 10 : 15),
              decoration: BoxDecoration(
                color: color,
                border: Border(
                  left: BorderSide(
                    color: borderColor,
                    width: 3.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  context.isMobile
                      ? const SizedBox.shrink()
                      : Image.asset(
                          imagePath,
                          height: context.isDesktop ? 60 : null,
                          width: !context.isDesktop ? 45 : null,
                        ),
                  context.isMobile
                      ? const SizedBox.shrink()
                      : const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.isMobile || context.isSmallTablet
                              ? context.titleSmall
                              : context.titleMedium,
                        ),
                        Text(
                          total,
                          style: GoogleFonts.figtree(
                            textStyle: context.isMobile || context.isSmallTablet
                                ? context.titleMedium
                                : context.titleLarge,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getJobCards(BuildContext context) {
    return BlocBuilder<JobsBloc, JobsState>(builder: (context, state) {
      var completedJobs = 0;
      var inProgressJobs = 0;
      if (state is JobsLoaded) {
        completedJobs = state.completedJobs;
        inProgressJobs = state.inProgressJobs;
      }

      final widgets = [
        _jobsTotalCard(context,
            color: AppColor.lightPurple,
            borderColor: AppColor.purple,
            title: "Jobs in construction",
            total: inProgressJobs.toString(),
            imagePath: 'assets/img/digger_1.png'),
        SizedBox(
          width: context.isDesktop ? 50 : 15,
          height: !context.isDesktop ? 10 : null,
        ),
        _jobsTotalCard(context,
            color: AppColor.lightGreen,
            borderColor: AppColor.green,
            title: "Jobs completed",
            total: completedJobs.toString(),
            imagePath: 'assets/img/digger_2.png'),
      ];

      if (context.isDesktop || context.isTablet) {
        return Row(
          children: widgets,
        );
      } else {
        return SizedBox(
          height: 75,
          child: Row(
            children: widgets,
          ),
        );
      }
    });
  }

  void _switchView(bool value) {
    setState(() {
      _calendarView = value;
    });
  }
}
