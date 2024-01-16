import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/map_failure_to_error_message.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/job_item_widget.dart';
import '../widgets/jobs_fiter_widget.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobsBloc>(
      create: (context) {
        JobsBloc jobsBloc = DependencyInjection.sl();
        jobsBloc.add(GetJobsEvent());
        return jobsBloc;
      },
      child: PageContainerWidget(
        title: "Jobs (Construction list)",
        child: Column(
          children: [
            if (context.isDesktop || context.isTablet)
              Row(
                children: _getJobCards(context),
              )
            else
              SizedBox(
                height: 180,
                child: Column(
                  children: _getJobCards(context),
                ),
              ),
            const JobsFilterWidget(),
            Expanded(
              child:
                  BlocBuilder<JobsBloc, JobsState>(builder: (context, state) {
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
                  return ListView.builder(
                    itemCount: state.jobs.length,
                    itemBuilder: (_, i) => const JobItemWidget(),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _jobsTotalCard(BuildContext context,
      {required Color color,
      required Color borderColor,
      required String title,
      required String total,
      required String imagePath}) {
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

  _getJobCards(BuildContext context) {
    return [
      _jobsTotalCard(context,
          color: AppColor.lightPurple,
          borderColor: AppColor.purple,
          title: "Jobs in construction",
          total: "2630",
          imagePath: 'assets/img/digger_1.png'),
      SizedBox(
        width: context.isDesktop ? 50 : context.isTablet ? 15 : null,
        height: !context.isDesktop ? 10 : null,
      ),
      _jobsTotalCard(context,
          color: AppColor.lightGreen,
          borderColor: AppColor.green,
          title: "Jobs completed",
          total: "2630",
          imagePath: 'assets/img/digger_2.png'),
    ];
  }
}
