import 'package:bflow_client/src/core/constants/colors.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/download_file_widget.dart';
import 'package:flutter/material.dart';

class JobFilesWidget extends StatelessWidget {
  const JobFilesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Documents"),
            ActionButtonWidget(
              onPressed: () {},
              type: ButtonType.elevatedButton,
              title: "Attach",
              icon: Icons.attach_file_outlined,
              backgroundColor: AppColor.blue,
              foregroundColor: AppColor.white,
            )
          ],
        ),
        const SizedBox(
          width: double.infinity,
          child: Wrap(
            spacing: 10,
            alignment: WrapAlignment.start,
            children: [
              DownloadFileWidget(),
              DownloadFileWidget(),
              DownloadFileWidget(),
              DownloadFileWidget(),
            ],
          ),
        )
      ],
    );
  }
}
