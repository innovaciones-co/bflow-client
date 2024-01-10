import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:flutter/material.dart';

import '../widgets/job_item_widget.dart';
import '../widgets/jobs_fiter_widget.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWidget(
      title: "Jobs (Construction list)",
      child: Column(
        children: [
          const JobsFilterWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (_, i) => const JobItemWidget(),
            ),
          )
        ],
      ),
    );
  }
}
