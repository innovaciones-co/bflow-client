import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/custom_chip_widget.dart';
import '../../domain/entities/job_entity.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;
  const JobItemWidget({
    super.key,
    required this.job,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      height: 120, // THIS
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: context.isMobile || context.isTablet || context.isSmallTablet
          ? _mobileLayout(context)
          : _desktopLayout(context),
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 15, right: 8, top: 15, bottom: 15),
      children: [
        _mobileCellJob(
            title: "Job Number", width: 110, child: Text(job.jobNumber)),
        _mobileCellJob(
            title: "Address",
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.address),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  child: const Text("Open in Goole maps"),
                ), // THIS ?link
              ],
            )),
        _mobileCellJob(
            title: "Supervisor",
            width: 140,
            child: const Text("Alberto Federico")),
        _mobileCellJob(
          title: "Job Stage",
          width: 110,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomChipWidget(
                label: "Slab down",
              ),
            ],
          ),
        ),
        _mobileCellJob(
            title: "Days in construction", width: 160, child: const Text("90")),
        _mobileCellJob(
          title: "Progress",
          width: 150,
          child: _progressBar(percentage: 0.7, width: 140),
        ),
        const SizedBox(width: 40),
        Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    vertical: 1, horizontal: 20), // THIS no hace nada
                foregroundColor: context.primary,
                backgroundColor: context.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                context.go(RoutesName.job);
              },
              child: const Text(
                'View details',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _desktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 8, top: 15, bottom: 15),
      child: Row(
        children: [
          _cellJob(title: "Job Number", flex: 1, child: Text(job.jobNumber)),
          _cellJob(
              title: "Address",
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.address),
                  TextButton(
                    onPressed: () {},
                    style:
                        TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                    child: const Text("Open in Goole maps"),
                  ), // THIS ?link
                ],
              )),
          _cellJob(
              title: "Supervisor",
              flex: 2,
              child: const Text("Alberto Federico")),
          _cellJob(
            title: "Job Stage",
            flex: 2,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomChipWidget(
                  label: "Slab down",
                ),
              ],
            ),
          ),
          _cellJob(
              title: "Days in construction", flex: 2, child: const Text("90")),
          _cellJob(
              title: "Progress",
              flex: 2,
              child: _progressBar(percentage: 0.7, width: 200)),
          Expanded(
            flex: 2,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1, horizontal: 20), // THIS no hace nada
                    foregroundColor: context.primary,
                    backgroundColor: context.background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'View details',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            widthFactor: percentage,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange.shade700,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        Center(
            child: Text(
          "${percentage * 100}% complete",
        )),
      ],
    ),
  );
}

SizedBox _mobileCellJob(
    {required String title, required double width, required Widget child}) {
  return SizedBox(
    width: width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}

Widget _cellJob(
    {required String title, required int flex, required Widget child}) {
  return Expanded(
    flex: flex,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 10),
        child,
      ],
    ),
  );
}
