import 'package:bflow_client/src/core/api/api_constants.dart';
import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/utils/launch_url.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/jobs_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobsActionBarWidget extends StatelessWidget {
  const JobsActionBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: TextField(
                onChanged: (val) => _searchJobs(val, context),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(color: AppColor.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide(color: AppColor.grey, width: 1.5),
                  ),
                  contentPadding:
                      const EdgeInsets.only(top: 0, bottom: 0, right: 10),
                  isDense: true,
                  filled: true,
                  fillColor: AppColor.white,
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search",
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              ActionButtonWidget(
                onPressed: () {
                  launchURL(
                      "${ApiConstants.serverDomain}/jobs/report?reportType=pdf");
                },
                icon: Icons.download,
                type: ButtonType.elevatedButton,
                title: 'Download report',
                backgroundColor: AppColor.lightBlue,
                foregroundColor: AppColor.blue,
              ),
              const SizedBox(width: 10),
              ActionButtonWidget(
                onPressed: () =>
                    context.showLeftDialog('New Job', WriteJobWidget()),
                icon: Icons.add,
                type: ButtonType.elevatedButton,
                title: 'New Job',
                backgroundColor: AppColor.blue,
                foregroundColor: AppColor.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _searchJobs(String value, BuildContext context) {
    if (value.isNotEmpty) {
      context.read<JobsBloc>().add(FilterJobsEvent(value));
    } else {
      context.read<JobsBloc>().add(GetJobsEvent());
    }
  }
}
