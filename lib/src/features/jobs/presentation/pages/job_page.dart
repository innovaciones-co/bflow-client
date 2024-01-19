import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:bflow_client/src/core/widgets/action_button_widget.dart';
import 'package:bflow_client/src/core/widgets/switch_widget.dart';
import 'package:bflow_client/src/features/jobs/domain/entities/job_entity.dart';
import 'package:bflow_client/src/features/jobs/presentation/widgets/job_item_widget.dart';
import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  final int jobId;
  const JobPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    Job job123 = Job(id: 12, jobNumber: "J123", name: "Coco Antonio", plannedStartDate: DateTime.now(), plannedEndDate: DateTime.now(), address: "Cll123", owner: "Hernesto Perez");
    return Scaffold(
      body: PageContainerWidget(
        title: "Call forward",
        child: Column(
          children: [
            JobItemWidget(job: job123),
            Row(
              children: [
                ActionButtonWidget(
                    onPressed: () {}, type: ButtonType.textButton, title: "View jobs documents", icon: Icons.all_inbox_sharp),
                ActionButtonWidget(
                    onPressed: () {}, type: ButtonType.textButton, title: "View all task", icon: Icons.task_outlined),
                const SwitchWidget(title: "View calendar",),
              ],
            ),
            Row(
              children: [
                const Text("Search"),
                ActionButtonWidget(onPressed: () {}, type: ButtonType.textButton, title: "Filter", icon: Icons.tune, foregroundColor: Colors.black,),
                const Text("Water Meter call up"),
                ActionButtonWidget(onPressed: () {}, type: ButtonType.textButton, title: "Delete", icon: Icons.delete_outline),
                ActionButtonWidget(onPressed: () {}, type: ButtonType.elevatedButton, title: "Send task", icon: Icons.mail_outline, backgroundColor: Colors.blue.shade50,),
                const SizedBox(width: 12),
                ActionButtonWidget(onPressed: () {}, type: ButtonType.elevatedButton, title: "New Activity", icon: Icons.add, backgroundColor: Colors.blue, foregroundColor: Colors.white,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
