import 'package:bflow_client/src/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class TableHeaderWidget extends StatelessWidget {
  final String label;
  const TableHeaderWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: context.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
