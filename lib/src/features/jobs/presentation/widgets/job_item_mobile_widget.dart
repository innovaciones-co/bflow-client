import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/extensions/format_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/write_job_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_chip_widget.dart';
import '../../domain/entities/job_entity.dart';

class JobItemMobileWidget extends StatelessWidget {
  final Job job;
  final bool viewDetailsEnabled;
  const JobItemMobileWidget({
    super.key,
    required this.job,
    this.viewDetailsEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: AppColor.lightGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomChipWidget(
                        label: job.stage.toString(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Row(
                      children: [
                        _cellFeature(
                          title: "Job Number",
                          flex: 1,
                          child: Text(job.jobNumber),
                        ),
                        _cellFeature(
                          title: "Supervisor",
                          flex: 1,
                          child: Text(job.supervisor.fullName),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 25, left: 25),
                    child: Row(
                      children: [
                        _cellFeature(
                          title: "Address",
                          flex: 1,
                          child: Text(job.address),
                        ),
                        _cellFeature(
                          title: "weeks",
                          flex: 1,
                          child: Text(job.weeksOfConstruction.toString()),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 20, right: 25, left: 25),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            _cellFeature(
                              title: "Progress",
                              flex: 1,
                              child: _progressBar(
                                  percentage: job.progress,
                                  width: double.infinity),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: Text(job.progress.toPercentage()),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, right: 25, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 20),
                        Expanded(
                          child: ActionButtonWidget(
                            onPressed: () => _goToDetails(context),
                            type: ButtonType.elevatedButton,
                            title: "View details",
                            paddingVertical: 0,
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 10,
          right: 3,
          child: IconButton(
            onPressed: () => _editJob(context),
            color: AppColor.blue,
            icon: const Icon(
              Icons.edit_outlined,
              size: 16,
            ),
            tooltip: 'Edit',
          ),
        )
      ],
    );
  }

  Widget _cellFeature(
      {required String title, required int flex, required Widget child}) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColor.darkGrey),
          ),
          const SizedBox(height: 3),
          child,
        ],
      ),
    );
  }

  Future<void> _editJob(BuildContext context) {
    return context.showLeftDialog(
      'Update Job',
      WriteJobWidget(
        job: job,
      ),
    );
  }

  void _goToDetails(BuildContext context) {
    context.go(RoutesName.job.replaceAll(":id", job.id.toString()));
  }
}

Widget _progressBar({required double percentage, required double width}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          width: width,
          margin: const EdgeInsets.only(top: 7),
          decoration: BoxDecoration(
            color: AppColor.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.orange,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
