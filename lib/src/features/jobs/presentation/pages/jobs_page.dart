import 'package:bflow_client/src/core/config/config.dart';
import 'package:bflow_client/src/core/exceptions/failure.dart';
import 'package:bflow_client/src/core/utils/map_failure_to_error_message.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
}
