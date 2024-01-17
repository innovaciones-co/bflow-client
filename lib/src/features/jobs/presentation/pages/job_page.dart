import 'package:bflow_client/src/core/widgets/page_container_widget.dart';
import 'package:flutter/material.dart';

class JobPage extends StatelessWidget {
  final int jobId;
  const JobPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return PageContainerWidget(
      title: "Call forward",
      child: Container(),
    );
  }
}
