import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/map_failure_to_error_message.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/core/widgets/switch_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/jobs_calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/job_item_widget.dart';
import '../widgets/jobs_action_bar_widget.dart';

class JobsPage extends StatefulWidget {
  const JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  bool _calendarView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageContainerWidget(
        title: "Jobs (Construction list)",
        actions: [
          SwitchWidget(
            value: _calendarView,
            onChanged: _switchView,
            title: "View calendar",
          ),
        ],
        child: !_calendarView
            ? _josGeneralView(context)
            : const JobsCalendarWidget(),
      ),
    );
  }

  Widget _josGeneralView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getJobCards(context),
          const JobsActionBarWidget(),
          BlocBuilder<JobsBloc, JobsState>(
            builder: (context, state) {
              if (state is JobsInitial) {
                return const SizedBox.shrink();
              }

              if (state is JobsError) {
                final message = mapFailureToErrorMessage(state.failure);
                return Center(
                  child: Text(message),
                );
              }

              if (state is JobsLoaded) {
                return Column(
                  children: state.jobsFiltered
                      .map((job) => JobItemWidget(
                            job: job,
                            viewDetailsEnabled: true,
                          ))
                      .toList(),
                );
              }

              return const SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                  Image.asset(
                    imagePath,
                    height: context.isDesktop ? 60 : null,
                    width: !context.isDesktop ? 45 : null,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: context.titleMedium,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          total,
                          style: GoogleFonts.figtree(
                            textStyle: context.titleLarge,
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
          width: context.isDesktop
              ? 50
              : context.isTablet
                  ? 15
                  : null,
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
          height: 180,
          child: Column(
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
