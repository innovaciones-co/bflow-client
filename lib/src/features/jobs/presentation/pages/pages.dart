import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class JobsPage extends StatelessWidget {
  const JobsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jobs Page",
            style: context.displaySmall,
          ),
        ],
      ),
    );
  }
}
