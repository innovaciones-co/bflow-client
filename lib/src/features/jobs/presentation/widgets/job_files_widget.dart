import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/bloc/job_bloc.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/file_download_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/file_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JobFilesWidget extends StatelessWidget {
  const JobFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobBloc, JobState>(
      builder: (context, state) {
        if (state is JobLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is JobLoaded) {
          return Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Documents"),
                    ActionButtonWidget(
                      onPressed: () => context.showModal("Upload file", [
                        FileUploadWidget(
                          jobId: state.job.id,
                        ),
                      ]),
                      type: ButtonType.elevatedButton,
                      title: "Attach",
                      icon: Icons.attach_file_outlined,
                      backgroundColor: AppColor.blue,
                      foregroundColor: AppColor.white,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                state.job.files != null
                    ? SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.start,
                          children: state.job.files!
                              .map((e) => FileDownloadWidget(
                                    file: e,
                                  ))
                              .toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Job Notes"),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                state.job.notes != null
                    ? _listNotes(state, context)
                    : const SizedBox.shrink()
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _listNotes(JobLoaded state, BuildContext context) {
    return Column(
      children: state.job.notes!
          .map(
            (e) => Container(
              width: context.width / 2,
              margin: const EdgeInsets.only(bottom: 15),
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
              padding: const EdgeInsets.all(25.0),
              child: Text(e.body),
            ),
          )
          .toList(),
    );
  }
}
